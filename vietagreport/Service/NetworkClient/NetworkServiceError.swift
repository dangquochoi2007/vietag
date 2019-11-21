//
//  NetworkServiceError.swift
//  vietagreport
//
//  Created by Hoi on 11/16/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
    case apiError
    case invalidRequestURL
    case invalidEndpoint
    case invalidResponse
    case noDataInResponse
    case noResponseReceived
    case decodeError
    case noInternet
    case userCancelled
    ///https://developer.apple.com/documentation/appstoreconnectapi/interpreting_and_handling_errors/about_the_http_status_code
    case badRequest
    case authenticationError
    case notFound
    case methodNotAllowed
    case notAcceptable
    case conflict
    case gone
    case unsupportedMediaType
    case unprocessableEntity
    case tooManyRequests
    case internalServerError
    
    var title: String {
        switch self {
        case .apiError:
            return NSLocalizedString("Invalid Cloudant Credentials", comment: "Credentials")
        default:
            return NSLocalizedString("Invalid Cloudant Credentials", comment: "Credentials")
        }
    }
    
    func message() -> String {
        switch self {
        case .apiError:
            return NSLocalizedString("Please check the readme for instructions on setting up your Cloudant database.", comment: "Cloudant database.")
        default:
            return NSLocalizedString("Please check the readme for instructions on setting up your Cloudant database.", comment: "Cloudant database.")
        }
    }
}
