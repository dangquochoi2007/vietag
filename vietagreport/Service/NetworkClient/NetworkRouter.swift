//
//  NetworkRouter.swift
//  vietagreport
//
//  Created by Hoi on 11/2/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation
import SafariServices

protocol NetworkRequestConvertible {
    func asURLRequest(with authorization: Authentication) throws -> URLRequest
}

enum NetworkRouter: NetworkRequestConvertible {
    case signup
    case login
    case logout
    case forgotPassword
    case search
    

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .signup:
            return .get
        default:
            return .get
        }
    }
    
    var baseURL: URL? {
        return URL(string: "https://api.github.com")
    }
    
    var path: String {
        switch self {
        case .signup:
            return ""
        case .login:
            return ""
        case .logout:
            return ""
        case .forgotPassword:
            return ""
        default:
            return ""
        }
    }
    
    func asURLRequest(with authorization: Authentication) throws -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(path) else {
            throw NetworkServiceError.invalidEndpoint
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
//        request.setValue(authorization.value, forHTTPHeaderField: authorization.key)
        return request
    }
}
