//
//  APIClientConfig.swift
//  SenioriOSPortfolio
//
//  Created by Sarah Clark on 3/27/25.
//

import Foundation

struct APIClientConfig {
    let requestsPerSecond: Int
    let maxRetries: Int
    let baseRetryDelay: TimeInterval
}
