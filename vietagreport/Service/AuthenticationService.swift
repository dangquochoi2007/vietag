//
//  AuthenticationService.swift
//  vietagreport
//
//  Created by Hoi on 11/16/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation

protocol Authentication {
    
    var key: String? { get }
    
    var value: String? { get }
}


class BasicAuthentication: Authentication {
    
    var username: String
    var password: String
    
    var key: String? {
        return "Authorization"
    }
    
    var value: String? {
        let authorizationValue =  "\(self.username):\(self.password)"
        return "Basic \(convertStringToBase64(value: authorizationValue) ?? "")"
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    private func convertStringToBase64(value: String) -> String? {
        guard let data = value.data(using: String.Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString()
    }
}

class TokenAuthentication: Authentication {
    
    var token: String
    
    var key: String? {
        return "Authorization"
    }
    
    var value: String? {
        return "bearer \(self.token)"
    }
    
    init(token: String) {
        self.token = token
    }
}

class AccessTokenAuthentication: Authentication {
    
    var accessToken: String
    
    var key: String? {
        return "access_token"
    }
    
    var value: String? {
        return self.accessToken
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
