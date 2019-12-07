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
    
    var noneAuthentication: Authentication!
    var basicAuthenication: BasicAuthentication!
    var accessTokenAuthentication: AccessTokenAuthentication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        noneAuthentication = NoneAuthentication()
        basicAuthenication = BasicAuthentication(username: username, password: password)
        accessTokenAuthentication = AccessTokenAuthentication(accessToken: accessToken)
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        noneAuthentication = nil
        basicAuthenication = nil
        accessTokenAuthentication = nil
    }
    
    func testHeadersMustHaveKeyValue() {
        XCTAssert(noneAuthentication.key == nil, "Authorize must have key value")
        XCTAssert(noneAuthentication.value == nil, "Authorize must have key value")
        
        XCTAssertTrue(basicAuthenication.key == "Authorization")
        XCTAssert(basicAuthenication.value != "Basic  ")
        XCTAssert(basicAuthenication.username == self.username, "Authorize must have username")
        XCTAssert(basicAuthenication.password == self.password, "Authorize must have password")
        
        XCTAssert(accessTokenAuthentication.key == "access_token", "Access Token must have token")
        XCTAssert(accessTokenAuthentication.accessToken == accessToken, "Access Token must have token")
    }
    
    func test_ValidCallAuthenticateHTTPStatus200() {
        // given
        let promise = expectation(description: "Login successful and status code: 304")
        guard let request = try? NetworkRouter.login.asURLRequest(with: basicAuthenication) else {
            XCTFail("Error: request invalid")
            promise.fulfill()
            return
        }
        var statusCode: Int?
        var responseError: Error?
        
        // when
        NetworkClient.shared.sendRequest(request: request, success: {
            statusCode = 200
            promise.fulfill()
        }) { (error) in
            XCTFail("Error: \(error.message())")
            responseError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: 15)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func test_VerifyDataModelAPIReturnCorrect_when_CallAPIGetName() {
        // given
       
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
