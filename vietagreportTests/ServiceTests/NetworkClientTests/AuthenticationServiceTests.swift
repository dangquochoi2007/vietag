//
//  AuthenticationServiceTests.swift
//  vietagreportTests
//
//  Created by Hoi Dang Quoc on 11/21/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import XCTest
@testable import vietagreport

class AuthenticationServiceTests: XCTestCase {
    
    var username: String = "username"
    var password: String = "password"
    var accessToken: String = "accessToken"
    
    var authentication: Authentication!
    var basicAuthenication: BasicAuthenication!
    var accessTokenAuthentication: AccessTokenAuthentication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        authentication = Authentication()
        basicAuthenication = BasicAuthenication(username: username, password: password)
        accessTokenAuthentication = AccessTokenAuthentication(accessToken: accessToken)
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        authentication = nil
        basicAuthenication = nil
        accessTokenAuthentication = nil
    }
    
    func testHeadersMustHaveKeyValue() {
        XCTAssert(authentication.headers().count > 0, "Authorize must have key value")
        XCTAssert(authentication.key == "")
        XCTAssert(authentication.value == "")
        
        XCTAssert(basicAuthenication.headers().count > 0, "Basic Auth must have username/password")
        XCTAssertTrue(basicAuthenication.key == "Authorization")
        XCTAssert(basicAuthenication.value != "Basic  ")
        XCTAssert(basicAuthenication.username == self.username)
        XCTAssert(basicAuthenication.password == self.password)
        
        XCTAssert(accessTokenAuthentication.headers().count > 0, "Access Token must have token")
        XCTAssert(accessTokenAuthentication.key == "access_token")
        XCTAssert(accessTokenAuthentication.accessToken == accessToken)
    }
    
    func test_ValidCallAuthenticateHTTPStatus200() {
        // given
        let promise = expectation(description: "Login successful and status code: 304")
        guard let request = try? NetworkRouter.login.asURLRequest(with: basicAuthenication) else {
            XCTFail("Error: request invalid")
            return
        }
        var statusCode: Int?
        var responseError: Error?
        
        // when
        NetworkClient.shared.sendRequest(request: request) { (data, response, error) in
            guard error == nil else {
                XCTFail("Error: \(error?.localizedDescription ?? "")")
                responseError = error
                promise.fulfill()
                return
            }
            guard let res = response as? HTTPURLResponse else {
                XCTFail("Error: have no http response")
                promise.fulfill()
                return
            }
            statusCode = res.statusCode
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func test_VerifyDataModelAPIReturnCorrect_when_CallAPIGetName() {
        // given
        let promise = expectation(description: "API return correct data format")
        guard let request = try? NetworkRouter.login.asURLRequest(with: basicAuthenication) else {
            XCTFail("Error: request invalid")
            return
        }
        struct Model: Decodable {
            var name: String
        }
        var model: [Model]?
        var responseError: NetworkServiceError?
        // when
        NetworkClient.shared.sendRequest(request: request) { (response: [Model]?, error) in
            guard error == nil else {
                XCTFail("Error: \(error?.localizedDescription ?? "")")
                responseError = error
                promise.fulfill()
                return
            }
            model = response
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(model)
    }
    
    func test_refreshToken_when_AccessTokenExpired() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
