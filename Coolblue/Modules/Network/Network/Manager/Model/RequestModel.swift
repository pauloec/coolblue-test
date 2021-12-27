//
//  RequestModel.swift
//  Network
//
//  Created by Paulo Correa on 11/12/2021.
//

import UIKit

public enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

open class RequestModel {
    public init() { }

    open var path: String {
        return ""
    }

    open var parameters: [String: Any?] {
        return [:]
    }

    open var headers: [String: String] {
        return [:]
    }

    open var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }

    open var body: [String: Any?] {
        return [:]
    }

    open var isLoggingEnabled: (request: Bool, response: Bool) {
        return (request: true, response: true)
    }
}

extension RequestModel {
    func urlRequest() -> URLRequest {
        var endpoint: String = ServiceManager.shared.baseURL.appending(path)

        for parameter in parameters {
            if let value = parameter.value as? String {
                endpoint.append("?\(parameter.key)=\(value)")
            }
        }

        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)

        request.httpMethod = method.rawValue

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        request.addValue("application/json", forHTTPHeaderField: "content-type")

        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                LogManager.e("Request body parse error: \(error.localizedDescription)")
            }
        }

        return request
    }
}
