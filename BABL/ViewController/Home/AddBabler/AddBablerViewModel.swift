//
//  AddBablerViewModel.swift
//  BABL
//

import Foundation
import UIKit

protocol UpdateBablerSendData: AnyObject {
    func didSendData(response: IdeaModel)
}

protocol AddBablerViewModelDelegate: AnyObject {
    func didReceiveHomeResponse(response: ContactListmodel)
}

struct AddBablerViewModel {
    var delegate: AddBablerViewModelDelegate?
    func getContactList(contactList: [String], token: String, view: UIView) {
        let dic: [String: [Any]] = ["phone_number": contactList]
        SessionManager.shared.methodForApiCalling(url: UrlName.contactlist, method: .post, parameter: dic, objectClass: ContactListmodel.self, requestCode: UrlName.contactlist, userToken: token) { response in
            DispatchQueue.main.async {
                delegate?.didReceiveHomeResponse(response: response)
                print(response.installed?.count ?? 0)
            }
        }
    }
}
