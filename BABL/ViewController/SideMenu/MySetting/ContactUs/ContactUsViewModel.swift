//
//  ContactUsViewModel.swift
//  BABL
//
//  Created by Aman Jadhav on 17/11/22.
//

import Foundation
import RealmSwift

protocol ContactUsViewModelDelegate: AnyObject {
    func didReceiveContactUsResponse(response: ContactUsModel)
}

struct ContactUsViewModel {
    var delegate: ContactUsViewModelDelegate?
    let resultsData = try! Realm().objects(UserTable.self)
    func methodForAPI(fullName: String, subject: String, description: String) {
        let dic: [String: Any] = ["full_name": fullName,
                                  "subject": subject,
                                  "message": description]
        SessionManager.shared.methodForApiCalling(url: UrlName.contactUs, method: .post, parameter: dic, objectClass: ContactUsModel.self, requestCode: UrlName.contactUs, userToken: resultsData.first?.token) { response in
                self.delegate?.didReceiveContactUsResponse(response: response)
        }
    }
}
