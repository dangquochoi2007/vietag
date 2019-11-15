//
//  NetworkRouter.swift
//  vietagreport
//
//  Created by Hoi on 11/2/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation

protocol NetworkRequestConvertible {
    func asURLRequest() throws -> URLRequest
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
        return URL(string: "")
    }
    
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: "") else {
            throw NetworkServiceError.invalidEndpoint
        }
        return URLRequest(url: url)
    }
}
