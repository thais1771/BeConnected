//
//  Endpoint.swift
//
//
//  Created by Thais Rodríguez on 11/5/23.
//

import Foundation

public protocol Endpoint {
    var apiKeyValue: String? { get }
    var apiKey: APIKEYType? { get }
    var path: String { get }
    var pathParams: [String: String]? { get }
    var headerParams: [String: String]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var method: HTTPMethod { get }
    var scheme: String? { get }
    var host: String { get }
}

public extension Endpoint {
    var contentType: String {
        "application/json"
    }

    var cachePolicy: URLRequest.CachePolicy {
        .returnCacheDataElseLoad
    }

    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme ?? "https"
        urlComponents.host = host
        urlComponents.path = path

        if let pathParams {
            urlComponents.queryItems = pathParams.compactMap {
                URLQueryItem(name: $0.key, value: $0.value)
            }.sorted(by: { $0.name < $1.name })
        }

        return urlComponents
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        if let apiKeyValue { request.setValue(apiKeyValue, forHTTPHeaderField: apiKey != nil ? apiKey!.rawValue : "apikey") }
        request.httpMethod = method.rawValue
        request.httpBody = getbody()

        if let headerParams {
            for headerParam in headerParams {
                request.setValue(headerParam.value, forHTTPHeaderField: headerParam.key)
            }
        }

        return request
    }

    private func getbody() -> Data? {
        if case let .POST(body) = method {
            return body
        }
        return nil
    }
}
