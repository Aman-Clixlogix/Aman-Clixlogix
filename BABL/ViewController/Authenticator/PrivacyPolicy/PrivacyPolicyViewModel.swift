//
//  PrivacyPolicyViewModel.swift
//  BABL
//

import Foundation


protocol PrivacyPolicyViewModelDelegate: AnyObject {
    func didReceivePrivacyPolicyResponse(response: PrivacyPolicyModel)
}

struct PrivacyPolicyViewModel {
    var delegate: PrivacyPolicyViewModelDelegate?
    func privacyPolicyAPI(api: String) {
        SessionManager.shared.methodForApiCalling(url: api, method: .get, parameter: nil, objectClass: PrivacyPolicyModel.self, requestCode: api, userToken: nil) { response in
                self.delegate?.didReceivePrivacyPolicyResponse(response: response)
        }
    }
}
