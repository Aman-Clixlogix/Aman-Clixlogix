//
//  LogoutViewModel.swift
//  BABL
//

import Foundation
import UIKit
import RealmSwift

protocol LogoutViewModelDelegate: AnyObject {
    func didReceiveLogoutResponse(response: LogoutModel)
}

struct LogoutViewModel {
    var delegate: LogoutViewModelDelegate?
    let resultsData = try! Realm().objects(UserTable.self)
    func logoutAPI(api: String) {
        let dic: [String: Any] = ["registration_id": UIDevice.current.identifierForVendor?.uuidString ?? ""]
        SessionManager.shared.methodForApiCalling(url: api, method: .post, parameter: dic, objectClass: LogoutModel.self, requestCode: api, userToken: resultsData.first?.token) { response in
                self.delegate?.didReceiveLogoutResponse(response: response)
        }
    }
}
