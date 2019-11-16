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
    var method: String {
        switch self {
        case .signup:
            return "GET"
        default:
            return "GET"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError("Error: Not implement base url")
        }
        return url
    }
    
    
    func asURLRequest(with authorization: Authentication) throws -> URLRequest {
        guard let url = URL(string: "") else {
            throw NetworkServiceError.invalidEndpoint
        }
        return URLRequest(url: url)
    }
}
