//
//  IdeaViewModel.swift
//  BABL
//

import Foundation
import RealmSwift

protocol IdeaViewModelDelegate: AnyObject {
    func didReceiveIdeaResponse(response: IdeaModel)
}

struct IdeaViewModel {
    var delegate: IdeaViewModelDelegate?
    let resultsData = try! Realm().objects(UserTable.self)
    func ideaAPI(id: String) {
        SessionManager.shared.methodForApiCalling(url: UrlName.ideaDetails + "\(id)/", method: .get, parameter: nil, objectClass: IdeaModel.self, requestCode: UrlName.createBabl, userToken: resultsData.first?.token ?? "") { response in
            DispatchQueue.main.async {
                delegate?.didReceiveIdeaResponse(response: response)
            }
        }
    }
}
