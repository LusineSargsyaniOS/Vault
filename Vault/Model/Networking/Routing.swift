//
//  Routing.swift
//  Routing
//
//  Created by Lusine Sargsyan on 2/20/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

protocol Routing {
    var baseURL: String { get }
    var urlRequest: URLRequest? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
}

extension Routing {
    var baseURL: String { return Text.URLPaths.baseURL }

    var urlRequest: URLRequest? {
        let baseURLStirng = baseURL

        guard var url = URL(string: baseURLStirng) else {
            #if DEV
                Logger.logString(string: "cannot create URL")
            #endif

            return nil
        }
        
        if !path.isEmpty {
            url.appendPathComponent(path)
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = self.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        if let parameters = self.parameters {
            do {
                urlRequest = try encoding.encode(request: urlRequest, parameters: parameters)
            } catch {
                #if DEV
                    Logger.logString(string: "parameters encoding isseu")
                #endif
            }
        }
        
        return urlRequest
    }

    var path: String { return "" }

    var method: HTTPMethod { return .GET }

    var parameters: [String: Any]? { return nil }

    var encoding: ParameterEncoding { return .url }

    var headers: [String : String]? { return ["Content-Type": "application/x-www-form-urlencoded"]}
}
