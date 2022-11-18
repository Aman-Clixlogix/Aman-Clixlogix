//
//  HomeViewModel.swift
//  BABL
//

import Foundation
import RealmSwift

protocol HomeViewModelDelegate: AnyObject {
    func didReceiveHomeResponse(homeResponse: HomeModel)
    func didReceiveHomeNextResponse(homeResponse: HomeModel)
}

struct HomeViewModel {
    var delegate: HomeViewModelDelegate?
    let resultsData = try! Realm().objects(UserTable.self)
    func homeFeedAPI() {
        SessionManager.shared.methodForApiCalling(url: UrlName.homeFeed, method: .get, parameter: nil, objectClass: HomeModel.self, requestCode: UrlName.homeFeed, userToken: resultsData.first?.token) { response in
            DispatchQueue.main.async {
                delegate?.didReceiveHomeResponse(homeResponse: response)
            }
        }
    }
    
    func homeNextAPI(api: String) {
        SessionManager.shared.methodForApiCalling(url: api, method: .get, parameter: nil, objectClass: HomeModel.self, requestCode: UrlName.homeFeed, userToken: resultsData.first?.token) { response in
            DispatchQueue.main.async {
                delegate?.didReceiveHomeNextResponse(homeResponse: response)
            }
        }
    }
}
