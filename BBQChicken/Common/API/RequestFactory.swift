//
//  RequestFactory.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/20/20.
//

import Foundation

enum RequestFactory {
    static func request(for endpoint: Endpoint) -> URLRequest? {
        guard let url = endpoint.urlComponents?.url else {
            return nil
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.httpMethod
        request.allHTTPHeaderFields = endpoint.httpHeaderFields

        return request
    }
}
