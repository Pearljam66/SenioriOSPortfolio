# Async Image Loader Problem

## Question
**Asynchronous Image Loader with Caching**

## Description
Build an `ImageLoader` class in Swift that:
- Asynchronously fetches an image from a given URL.
- Caches the image in memory using `NSCache` to avoid redundant network requests.
- Provides a completion handler to return the `UIImage` or an error.
- Cancels ongoing requests if needed (e.g., using `URLSessionTask`).

The implementation should prioritize efficiency and user experience in a networked environment.

## Requirements
- Use modern Swift concurrency (`async/await`) for the network request.
- Ensure **thread safety** for cache access.
- Handle errors (e.g., invalid URL, network failure).
- **Timeframe**: 60 minutes  
  *(This gives time to implement async/await, caching, cancellation, and error handling.)*

## Solution
The solution is implemented in [`ImageLoader.swift`](./ImageLoader.swift). It features:
- `async/await` for clean, modern network calls via `URLSession`.
- `NSCache` for in-memory caching, inherently thread-safe.
- Support for request cancellation using `URLSessionTask`.
- Error handling with a custom `ImageLoaderError` enum.

## Usage
Example usage in Swift:
```swift
let loader = ImageLoader()
await loader.loadImage(from: URL(string: "https://example.com/image.jpg")!) { result in
    switch result {
    case .success(let image): print("Loaded image: \(image)")
    case .failure(let error): print("Error: \(error)")
    }
}
