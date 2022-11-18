//
//  ForgotPasswordViewModel.swift
//  BABL
//

import Foundation
import RealmSwift

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func didReceiveForgotPasswordResponse(response: String)
}

struct ForgotPasswordViewModel {
    var delegate: ForgotPasswordViewModelDelegate?
    func forgotPasswordAPI(email: String) {
        let dic: [String: Any] = ["email": email]
        SessionManager.shared.methodForApiCalling(url: UrlName.forgotPassword, method: .post, parameter: dic, objectClass: LoginModel.self, requestCode: UrlName.passwordUpdate, userToken: nil) { response in
            delegate?.didReceiveForgotPasswordResponse(response: AppErrorAndAlerts.checkYourMail.rawValue)
        }
    }
}
