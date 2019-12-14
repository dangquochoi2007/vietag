//
//  NetworkClient.swift
//  vietagreport
//
//  Created by Hoi on 10/30/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation
import Dispatch
import UIKit
//https://developer.apple.com/documentation/foundation/url_loading_system/handling_an_authentication_challenge
//Handling an Authentication Challenge
//

// Properly checks and handles the status code of the response
protocol NetworkClientProtocol {
    func sendRequest(request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (NetworkServiceError) -> Void)
    func sendRequest<T: Decodable>(request: URLRequest, success: @escaping (T) -> Void, failure: @escaping (NetworkServiceError) -> Void)
    func sendRequest(request: URLRequest, success: @escaping () -> Void,failure: @escaping(NetworkServiceError) -> Void)
    func cancelRequest(_ requestID: String)
    func cancelAllRequest()
}

class NetworkClient:NSObject, NetworkClientProtocol, URLSessionDelegate {

    static let shared = NetworkClient()
    
    
    enum MIMEType: String {
        case json = "application/json"
        case urlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
    }
    
    //
    
    private var session: URLSession?
    private let queue = DispatchQueue(label: "network-client")
    private let defaultHeaders:[AnyHashable : Any] = [
        "Content-type": MIMEType.json.rawValue,
        "Accept": MIMEType.json.rawValue
    ]
    
    private let userAgent: String = {
        let info = Bundle.main.infoDictionary
        let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let bundleVersion = info?["CFBundleVersion"] as? String ?? "-"
        let systemVersion = UIDevice.current.systemVersion
        return "RC Mobile; iOS \(systemVersion); v\(appVersion) (\(bundleVersion))"
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Initialization
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0)
        configuration.httpMaximumConnectionsPerHost = 2
        configuration.httpAdditionalHeaders = defaultHeaders
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    deinit {
        session?.invalidateAndCancel()
        session = nil
    }
    
    // MARK: - NetworkClientProtocol
    func sendRequest(request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (NetworkServiceError) -> Void) {
        self.retry(attempts: 3, task: { (success, failure) in
            self.logRequests(request: request, data: request.httpBody)
            self.session?.dataTask(with: request) { (data, response, error) in
                do {
                    self.logRequests(request: nil, data: data, response: response, error: error)
                    switch (data, response, error) {
                    case (nil, nil, let networkError?):
                        try self.convertNetworkServiceError(error: networkError)
                    case (let jsonData?, let response?, _) where try self.validStatusCode(response: response):
                        success(jsonData)
                    default:
                        throw NetworkServiceError.noDataInResponse
                    }
                } catch let networkError as NetworkServiceError {
                    failure(networkError)
                } catch let exception {
                    debugPrint("exception ", exception)
                    failure(NetworkServiceError.decodeError)
                }
            }.resume()
        }, success: success, failure: failure)
    }
    
    func sendRequest<T: Decodable>(request: URLRequest, success: @escaping (T) -> Void, failure: @escaping (NetworkServiceError) -> Void) {
        retry(attempts: 3, task: { (success, failure) in
            self.logRequests(request: request, data: request.httpBody)
            self.session?.dataTask(with: request) { (data, response, error) in
                do {
                    self.logRequests(request: nil, data: data, response: response, error: error)
                    switch (data, response, error) {
                    case (nil, nil, let networkError?):
                        try self.convertNetworkServiceError(error: networkError)
                    case (let jsonData?, let response?, _) where try self.validStatusCode(response: response):
                        success(try self.decoder.decode(T.self, from: jsonData))
                    default:
                        throw NetworkServiceError.noDataInResponse
                    }
                } catch let networkError as NetworkServiceError {
                    failure(networkError)
                } catch let exception {
                    debugPrint("exception ", exception)
                    failure(NetworkServiceError.decodeError)
                }
            }.resume()
        }, success: success, failure: failure)
    }
    
    func sendRequest(request: URLRequest, success: @escaping () -> Void,failure: @escaping(NetworkServiceError) -> Void) {
        self.retry(attempts: 3, task: { (success, failure) in
            self.logRequests(request: request, data: request.httpBody)
            self.session?.dataTask(with: request) { (data, response, error) in
                do {
                    self.logRequests(request: nil, data: data, response: response, error: error)
                    switch (data, response, error) {
                    case (nil, nil, let networkError?):
                        try self.convertNetworkServiceError(error: networkError)
                    case (_, let response?, _) where try self.validStatusCode(response: response):
                        success()
                    default:
                        throw NetworkServiceError.noDataInResponse
                    }
                } catch let networkError as NetworkServiceError {
                    failure(networkError)
                } catch let exception {
                    debugPrint("exception ", exception)
                    failure(NetworkServiceError.decodeError)
                }
            }.resume()
        }, success: success, failure: failure)
    }
    
    private func retry(attempts: Int,
               task: @escaping (_ success: @escaping (Data) -> Void, _ failure: @escaping (NetworkServiceError) -> Void) -> Void,
               success: @escaping (Data) -> Void,
               failure: @escaping (NetworkServiceError) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        task(success, { error in
            if attempts > 1 {
                _ = semaphore.wait(timeout: DispatchTime.now() + 2)
                self.retry(attempts: attempts - 1, task: task, success: success, failure: failure)
            } else {
                semaphore.signal()
                failure(error)
            }
        })
    }
    
    private func retry<T: Decodable>(attempts: Int,
                       task: @escaping (_ success: @escaping (T) -> Void, _ failure: @escaping (NetworkServiceError) -> Void) -> Void,
                       success: @escaping (T) -> Void,
                       failure: @escaping (NetworkServiceError) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        task(success, { error in
            if attempts > 1 {
                _ = semaphore.wait(timeout: DispatchTime.now() + 2)
                self.retry(attempts: attempts - 1, task: task, success: success, failure: failure)
            } else {
                semaphore.signal()
                failure(error)
            }
        })
    }
    
    private func retry(attempts: Int,
               task: @escaping(_ success: @escaping () -> Void, _ failure: @escaping (NetworkServiceError) -> Void) -> Void,
               success: @escaping () -> Void,
               failure: @escaping (NetworkServiceError) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        task(success, { error in
            if attempts > 1 {
                _ = semaphore.wait(timeout: DispatchTime.now() + 2)
                self.retry(attempts: attempts - 1, task: task, success: success, failure: failure)
            } else {
                semaphore.signal()
                failure(error)
            }
        })
    }

    private func convertNetworkServiceError(error: Error) throws {
        switch error {
        case URLError.notConnectedToInternet, URLError.networkConnectionLost, URLError.cannotLoadFromNetwork:
            throw NetworkServiceError.noInternet
        case URLError.cannotFindHost:
            throw NetworkServiceError.decodeError
        case URLError.cancelled:
            throw NetworkServiceError.userCancelled
        default:
            throw NetworkServiceError.invalidRequestURL
        }
    }
    
    private func validStatusCode(response: URLResponse) throws -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.apiError
        }
        switch httpResponse.statusCode {
        case 300...399:
            throw NetworkServiceError.invalidRequestURL
        case 401:
            throw NetworkServiceError.authenticationError
        case 400...499:
            throw NetworkServiceError.badRequest
        case 500...599:
            throw NetworkServiceError.internalServerError
        default:
            return 200...299 ~= httpResponse.statusCode
        }
    }
    
    func cancelRequest(_ requestID: String) {
        let semaphore = DispatchSemaphore(value: 0)
        session?.getTasksWithCompletionHandler({ (dataTasks, uploadTasks, downloadTasks) in
            var tasks = [URLSessionTask]()
            tasks.append(contentsOf: dataTasks as [URLSessionTask])
            tasks.append(contentsOf: uploadTasks as [URLSessionTask])
            tasks.append(contentsOf: downloadTasks as [URLSessionTask])
            
            for task in tasks {
                if task.taskDescription == requestID {
                    task.cancel()
                }
            }
            semaphore.signal()
        })
        _ = semaphore.wait(timeout: .now() + 60.0)
    }
    
    func cancelAllRequest() {
        let semaphore = DispatchSemaphore(value: 0)
        session?.getTasksWithCompletionHandler({ (dataTasks, uploadTasks, downloadTasks) in
            for sessionTask in dataTasks {
                sessionTask.cancel()
            }
            for sessionTask in uploadTasks {
                sessionTask.cancel()
            }
            for sessionTask in downloadTasks {
                sessionTask.cancel()
            }
            semaphore.signal()
        })
        _ = semaphore.wait(timeout: .now() + 60.0)
    }
    
    func logRequests(request: URLRequest?, data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        if let request = request {
            debugPrint("⚡[Request] \(request.httpMethod ?? "")", request.url?.absoluteString ?? "", separator: " - ", terminator: "\n")
        }
        if let data = data, let httpResponse = response as? HTTPURLResponse {
            let jsonString = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            debugPrint("😘 [Response] \(httpResponse.statusCode) ", jsonString ?? "invalid json")
        }
        if let error = error {
            debugPrint("😕 [Response] ", error)
        }
    }

    //https://github.com/radianttap/Avenue/blob/v2/NetworkSession.swift
    //URLSessionDelegate
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        debugPrint("URLAuthenticationChallenge ", challenge)
//        refreshAccessToken() { newAccessToken:String in
//            completionHandler(.useCredential, "Bearer \(newAccessToken)")
//        }
//        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodDefault ||
//            challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
//
//            let credential = URLCredential(user: self.basicAuthUserName,
//                                           password: self.basicAuthPassword,
//                                           persistence: .forSession)
//
//            completionHandler(.useCredential, credential)
//        }
//        else {
            completionHandler(.performDefaultHandling, nil)
//        }
//        completionHandler(.useCredential,
//                          URLCredential(user: "", password: "", persistence: URLCredential.Persistence.forSession))
    }
    
    
    
}
