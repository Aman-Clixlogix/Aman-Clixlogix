//
//  SignupViewModel.swift
//  BABL
//

import Foundation
import UIKit

protocol SignupViewModelDelegate: AnyObject {
    func didReceiveSignupResponse(signupResponse: SignupModel)
}

struct SignupViewModel {
    var delegate: SignupViewModelDelegate?
    var sessionManager = SessionManager()
    
    func signupUser(userName: String, firstName: String, lastName: String, email: String, countryCode: String, phone: String, password: String, registrationId: String) {
        let dic = ["username": userName,
                   "first_name": firstName,
                   "last_name": lastName,
                   "invite_code": "",
                   "email": email,
                   "country_code": countryCode,
                   "phone_number": phone,
                   "password": password,
                   "password2": password,
                   "registration_id": registrationId]
        SessionManager.shared.methodForApiCalling(url: UrlName.signup, method: .post, parameter: dic, objectClass: SignupModel.self, requestCode: UrlName.signup, userToken: nil) { response in
            UserDefaults.standard.removeObject(forKey: UD_TOKEN)
            UserDefaults.standard.set(response.token ?? "", forKey: UD_TOKEN)
            delegate?.didReceiveSignupResponse(signupResponse: response)
        }
    }
}
