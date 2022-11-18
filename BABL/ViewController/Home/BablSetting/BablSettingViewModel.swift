//
//  BablSettingViewModel.swift
//  BABL
//

import Foundation
import RealmSwift

protocol BablSettingViewModelDelegate: AnyObject {
    func didReceiveBablSettingResponse(response: BablSettingModel)
}

struct BablSettingViewModel {
    var delegate: BablSettingViewModelDelegate?
    let resultsData = try! Realm().objects(UserTable.self)
    func createBablAPI(description: String, submit_by: String, winner_by: String, anonymize: Bool, bablers: [Dictionary<String, Any>]) {
        let dic: [String: Any] = ["description": description,
                                  "submit_by": submit_by,
                                  "winner_by": winner_by,
                                  "anonymize": anonymize,
                                  "bablers": bablers]
        SessionManager.shared.methodForApiCalling(url: UrlName.createBabl, method: .post, parameter: dic, objectClass: BablSettingModel.self, requestCode: UrlName.createBabl, userToken: resultsData.first?.token ?? "") { response in
            DispatchQueue.main.async {
                delegate?.didReceiveBablSettingResponse(response: response)
            }
        }
    }
}
