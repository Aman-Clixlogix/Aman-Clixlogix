//
//  LoginViewModel.swift
//  BABL
//

import Foundation
import UIKit
import Alamofire

protocol LoginViewModelDelegate: AnyObject {
    func didReceiveLoginResponse(loginResponse: LoginModel)
}

struct LoginViewModel {
    var delegate: LoginViewModelDelegate?
    func loginUser(email: String, password: String, registrationId: String, view: UIView, completion: @escaping(AFDataResponse<Any>) -> Void) {
        let dic = ["email": email,
                   "password": password,
                   "registration_id": registrationId]
        SessionManager.shared.methodForApiCalling(url: UrlName.login, method: .post, parameter: dic, objectClass: LoginModel.self, requestCode: UrlName.login, userToken: nil) { response in
            self.delegate?.didReceiveLoginResponse(loginResponse: response)
        }
        
    }
}
