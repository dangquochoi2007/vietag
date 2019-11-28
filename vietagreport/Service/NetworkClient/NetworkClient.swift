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
    func sendRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func sendRequest<T: Decodable>(request: URLRequest, completion: @escaping (T?, NetworkServiceError?) -> Void)
    func sendRequest(request: URLRequest, completion: @escaping (NetworkServiceError?) -> Void)
    func cancelRequest(_ requestID: String)
    func cancelAllRequest()
}

class NetworkClient:NSObject, NetworkClientProtocol, URLSessionDelegate {
    
    enum MIMEType: String {
        case json = "application/json"
        case urlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
    }
    
    //
    static let shared = NetworkClient()
    
    private var session: URLSession?
    private var dataTask: URLSessionTask?
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
    
    // MARK: - NetworkClientProtocol
    func sendRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask = session?.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
        self.dataTask?.resume()
    }
    
    func sendRequest<T: Decodable>(request: URLRequest, completion: @escaping (T?, NetworkServiceError?) -> Void) {
        self.dataTask = session?.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                var networkServiceResult: T? = nil
                var networkServiceError: NetworkServiceError? = nil
                do {
                    if let networkError = error {
                        networkServiceError = self.convertNetworkServiceError(error: networkError)
                    } else if let res = response as? HTTPURLResponse,
                        let networkError = self.validateStatusCode(response: res){
                        networkServiceError = networkError
                    } else if let jsonData = data {
                        networkServiceResult = try self.decoder.decode(T.self, from: jsonData)
                    }
                } catch {
                    networkServiceError = NetworkServiceError.decodeError
                }
                completion(networkServiceResult, networkServiceError)
            }
        }
        self.dataTask?.resume()
    }
    
    func sendRequest(request: URLRequest, completion: @escaping(NetworkServiceError?) -> Void) {
        self.dataTask = session?.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                var networkServiceError: NetworkServiceError? = nil
                if let networkError = error {
                    networkServiceError = self.convertNetworkServiceError(error: networkError)
                } else if let res = response as? HTTPURLResponse {
                    networkServiceError = self.validateStatusCode(response: res)
                }
                completion(networkServiceError)
            }
        }
        self.dataTask?.resume()
    }
    
    private func convertNetworkServiceError(error: Error) -> NetworkServiceError? {
        switch error {
        case URLError.notConnectedToInternet, URLError.networkConnectionLost:
            return NetworkServiceError.noInternet
        case URLError.cannotFindHost:
            return NetworkServiceError.decodeError
        case URLError.cancelled:
            return NetworkServiceError.userCancelled
        default:
            return NetworkServiceError.invalidRequestURL
        }
    }
    
    private func validateStatusCode(response: HTTPURLResponse) -> NetworkServiceError? {
        switch response.statusCode {
        case 200...299:
            //success
            return nil
        case 401:
            return NetworkServiceError.authenticationError
        case 400...499:
            return NetworkServiceError.badRequest
        case 500...599:
            return NetworkServiceError.internalServerError
        default:
            return NetworkServiceError.apiError
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
    
    func logRequests(urlRequest: URLRequest) {
        debugPrint("? Running request: \(urlRequest.httpMethod ?? "") - \(urlRequest.url?.absoluteString ?? "")")
    }

    //https://github.com/radianttap/Avenue/blob/v2/NetworkSession.swift
    //URLSessionDelegate
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
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
//            completionHandler(.performDefaultHandling, nil)
//        }
        completionHandler(.useCredential,
                          URLCredential(user: "", password: "", persistence: URLCredential.Persistence.forSession))
    }
    
    
}
