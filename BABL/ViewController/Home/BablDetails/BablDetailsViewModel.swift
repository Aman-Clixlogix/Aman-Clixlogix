//
//  BablDetailsViewModel.swift
//  BABL
//
//  Created by Aman Jadhav on 17/11/22.
//

import Foundation
import RealmSwift

protocol BablDetailsViewModelDelegate: AnyObject {
    func didReceiveBablDetailsResponse(response: IdeaModel)
}

struct BablDetailsViewModel {
    var delegate: BablDetailsViewModelDelegate?
    let resultsData = try! Realm().objects(UserTable.self)
    func updateBablAPI(bablID: String, anonymize: Bool, bablers: [Dictionary<String, Any>]) {
        let dic: [String: Any] = ["anonymize": anonymize,
                                  "bablers": bablers]
        SessionManager.shared.methodForApiCalling(url: UrlName.createBabl + bablID + "/change/", method: .put, parameter: dic, objectClass: IdeaModel.self, requestCode: UrlName.createBabl + bablID + "/change/", userToken: resultsData.first?.token ?? "") { response in
            DispatchQueue.main.async {
                delegate?.didReceiveBablDetailsResponse(response: response)
            }
        }
    }
}
