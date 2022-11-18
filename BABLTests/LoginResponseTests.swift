//
//  LoginResponseTest.swift
//  BABLTests
//

import XCTest
@testable import BABL


class LoginResponseTest: XCTestCase {
    
    var loginViewModel: LoginViewModel?
    var loginVC: LoginVC?

    override func setUpWithError() throws {
        loginViewModel = LoginViewModel()
        loginVC = LoginVC()
    }

    override func tearDownWithError() throws {
        loginViewModel = nil
        loginVC = nil
    }

    func testLoginResponse() throws {
        let expectation = self.expectation(description: "Login Response Parse Expectation")
        loginViewModel?.loginUser(email: "ross@gmail.com", password: "Ross@123", registrationId: UIDevice.current.identifierForVendor?.uuidString ?? "", view: UIView(), completion: { response in
            XCTAssertNil(response.error)
            do {
                let json = (try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: [])) as? [String: AnyObject]
                let decoder = try JSONDecoder().decode(LoginModel.self, from: response.data ?? Data())
                XCTAssertNotNil(decoder)
                XCTAssertEqual("ross@gmail.com", decoder.email ?? "")
                expectation.fulfill()
            } catch {
                XCTFail(response.error?.localizedDescription ?? "")
            }
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
