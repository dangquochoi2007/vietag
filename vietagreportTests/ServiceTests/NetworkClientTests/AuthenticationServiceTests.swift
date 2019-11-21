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
    
    func testValidCallAuthenticateHTTPStatus200() {
        let promise = expectation(description: "Login successful and status code: 200")
        
        guard let request = try? NetworkRouter.login.asURLRequest(with: basicAuthenication) else {
            XCTFail("Error: request invalid")
            return
        }
        NetworkClient.shared.sendRequest(request: request) { (data, response, error) in
            guard error != nil else {
                XCTFail("Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let res = response as? HTTPURLResponse else {
                promise.fulfill()
                XCTFail("Error: have no http response")
                return
            }
            if res.statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Error: Status code invalid: \(res.statusCode)")
            }
        }
        
        wait(for: [promise], timeout: 20)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
