//
//  APIError.swift
//  SenioriOSPortfolio
//
//  Created by Sarah Clark on 3/27/25.
//

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case rateLimitExceeded
    case httpError(Int)
    case decodingError(Error)
    case maxRetriesExceeded
}
