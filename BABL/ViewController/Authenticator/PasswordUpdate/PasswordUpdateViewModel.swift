//
//  PasswordUpdateViewModel.swift
//  BABL
//

import Foundation
import RealmSwift

protocol PasswordUpdateViewModelDelegate: AnyObject {
    func didReceivePasswordUpdateResponse(response: String)
}

struct PasswordUpdateViewModel {
    var delegate: PasswordUpdateViewModelDelegate?
    func passwordUpdateAPI(password: String, token: String) {
        let dic: [String: Any] = ["token": token,
                                  "password": password]
        SessionManager.shared.methodForApiCalling(url: UrlName.passwordUpdate, method: .post, parameter: dic, objectClass: LoginModel.self, requestCode: UrlName.passwordUpdate, userToken: nil) { response in
            delegate?.didReceivePasswordUpdateResponse(response: AppErrorAndAlerts.passwordChangeSuccessful.rawValue)
        }
    }
}
