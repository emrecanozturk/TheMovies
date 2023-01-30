//
//  NetworkRequest.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import Foundation

/**
 A protocol to wrap request objects. This gives us a better API over URLRequest.
 */
protocol Requestable {
    /**
     Generates a URLRequest from the request. This will be run on a background thread so model parsing is allowed.
     */
    func urlRequest() -> URLRequest
}

/**
 A simple request with no post data.
 */
struct NetworkRequest: Requestable {
    private let baseURL   : String = "https://api.themoviedb.org/3"
    private var queryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: "8173ebed067385b8429b51ca9a1e610c")]
    private let path      : String
    private let method    : String

    init(path: String, method: String = "GET", queryItems: [URLQueryItem] = []) {
        self.path = path
        self.method = method
        self.queryItems.append(contentsOf: queryItems)
    }

    func urlRequest() -> URLRequest {
        guard var url = URL(string: baseURL + path) else {
            Logger.assertFailure("Failed to create base url")
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
        url.append(queryItems: queryItems)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        return urlRequest
    }
}

/**
 A request which includes post data. This should be the form of an encodeable model.
 */
struct PostRequest<Model: Encodable>: Requestable {
    private let baseURL: String = "https://api.themoviedb.org/3"
    public let path    : String
    public let model   : Model

    func urlRequest() -> URLRequest {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
            Logger.assertFailure("Failed to create base url")
            return URLRequest(url: URL(fileURLWithPath: ""))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model)
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error {
            Logger.assertFailure("Post request model parsing failed: \(error.localizedDescription)")
        }

        return urlRequest
    }
}

/**
 Making URLRequest also conform to request so it can be used with our stack.
 */
extension URLRequest: Requestable {
    func urlRequest() -> URLRequest {
        return self
    }
}
