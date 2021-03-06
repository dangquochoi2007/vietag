//
//  HTTPMethod.swift
//  vietagreport
//
//  Created by Hoi Dang Quoc on 11/27/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
