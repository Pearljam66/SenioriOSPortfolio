//
//  APIClient.swift
//  SenioriOSPortfolio
//
//  Created by Sarah Clark on 3/27/25.
//

import Foundation
// import PlaygroundSupport
// PlaygroundPage.current.needsIndefiniteExecution = true

class APIClient {
    private let config: APIClientConfig
    private let session: URLSession
    private let semaphore: DispatchSemaphore
    private let queue = DispatchQueue(label: "com.apiClient.rateLimitQueue", attributes: .concurrent)
    private var requestTimestamps: [Date] = []
    private let lock = NSLock()

    init(config: APIClientConfig = APIClientConfig(requestsPerSecond: 5, maxRetries: 3, baseRetryDelay: 1.0), session: URLSession = .shared) {
        self.config = config
        self.session = session
        self.semaphore = DispatchSemaphore(value: config.requestsPerSecond)
    }

    func fetch<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        try enforceRateLimit()

        return try await executeRequest(url: url, as: type, attempt: 1)
    }

    private func executeRequest<T: Decodable>(url: URL, as type: T.Type, attempt: Int) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                    case 200..<300:
                        break
                    case 429:
                        throw APIError.rateLimitExceeded
                    default:
                        throw APIError.httpError(httpResponse.statusCode)
                }
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data)
                return result
            } catch {
                throw APIError.decodingError(error)
            }
        } catch {
            if shouldRetry(error: error, attempt: attempt) {
                let delay = calculateBackoff(attempt: attempt)
                print("Retrying request (attempt \(attempt + 1)) after \(delay)s delay due to error: \(error)")
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000)) // Async delay
                return try await executeRequest(url: url, as: type, attempt: attempt + 1)
            } else {
                if attempt >= config.maxRetries {
                    throw APIError.maxRetriesExceeded
                }
                throw error
            }
        }
    }

    private func enforceRateLimit() throws {
        semaphore.wait()

        lock.lock()
        defer { lock.unlock() }

        let now = Date()
        requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) < 1.0 }

        if requestTimestamps.count >= config.requestsPerSecond {
            semaphore.signal()
            throw APIError.rateLimitExceeded
        }

        requestTimestamps.append(now)

        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.semaphore.signal()
        }
    }

    private func shouldRetry(error: Error, attempt: Int) -> Bool {
        guard attempt < config.maxRetries else { return false }

        switch error {
            case APIError.networkError, APIError.rateLimitExceeded, APIError.httpError(503):
                return true
            default:
                return false
        }
    }

    private func calculateBackoff(attempt: Int) -> TimeInterval {
        return config.baseRetryDelay * pow(2.0, Double(attempt - 1))
    }

}


struct Post: Codable {
    let id: Int
    let title: String
}

@MainActor
func example() async {
    let client = APIClient()
    do {
        let posts = try await client.fetch(from: "https://jsonplaceholder.typicode.com/posts", as: [Post].self)
        print("Fetched \(posts.count) posts:")
        for post in posts.prefix(5) {
            print("- \(post.title)")
        }
    } catch {
        print("Error: \(error)")
    }
    // PlaygroundPage.current.finishExecution()
}

// For running the code in playgrounds.
/*
 Task {
    await example()
}
*/
