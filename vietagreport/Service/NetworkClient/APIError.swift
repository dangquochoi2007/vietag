//
//  APIError.swift
//  vietagreport
//
//  Created by Hoi on 11/21/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation

struct APIError: Decodable {
    struct NetworkError: Decodable {
        var status: String?
        var id: String?
        var title: String?
        var detail: String?
        var code: String?
    }
    
    var message: String?
    var documentationUrl: String?
    var errors: [NetworkError]?
}
