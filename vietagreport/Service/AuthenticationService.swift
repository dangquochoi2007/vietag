//
//  AuthenticationService.swift
//  vietagreport
//
//  Created by Hoi on 11/16/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation

enum AuthenticationType {
    case none
    case headers
    case parameters
}

class Authentication {

    var type: AuthenticationType {
        return .none
    }
    
    var key: String {
        return ""
    }
    
    var value: String {
        return ""
    }
    
    init() {
        
    }
    
    func headers() -> [String: String] {
        return [key: value]
    }
}


class BasicAuthenication: Authentication {
    
    var username: String
    var password: String
    
    override var type: AuthenticationType {
        return .headers
    }

    override var key: String {
        return "Authorization"
    }
    
    override var value: String {
        let authorization = self.username + ":" + self.password
        return "Basic \(convertStringToBase64(value: authorization) ?? "")"
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    private func convertStringToBase64(value: String) -> String? {
        guard let data = Data(base64Encoded: value) else {
            return nil
        }
        return data.base64EncodedString()
    }
}

class TokenAuthentication: Authentication {
    
    var token: String
    
    override var type: AuthenticationType {
        return AuthenticationType.headers
    }
    
    override var key: String {
        return "Authorization"
    }
    
    override var value: String {
        return "bearer \(self.token)"
    }
    
    init(token: String) {
        self.token = token
    }
}

class AccessTokenAuthentication: Authentication {
    
    var accessToken: String
    
    override var type: AuthenticationType {
        return AuthenticationType.parameters
    }
    
    override var key: String {
        return "access_token"
    }
    
    override var value: String {
        return self.accessToken
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
