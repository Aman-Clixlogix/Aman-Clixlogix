//
//  UploadProfileViewModel.swift
//  BABL
//

import Foundation
import RealmSwift

protocol UploadProfileViewModelDelegate: AnyObject {
    func didReceiveUploadProfileResponse(profileResponse: UpdateProfileModel)
}

struct UploadProfileViewModel {
    var delegate: UploadProfileViewModelDelegate?
    let resultsData = try? Realm().objects(UserTable.self)
    func profileSetupAPI(image: UIImage, email: String, pronouns: String) {
        let token = UserDefaults.standard.string(forKey: UD_TOKEN) ?? ""
        let dic: [String: Any] = ["email": email, "pronouns": pronouns]
        SessionManager.shared.multipartformPostrequest(url: (UrlName.updateProfile + (resultsData?.first?.profileId ?? "")) + "/", method: .put, param: dic, imageKey: "profile_image", image: image, imageName: "file.jpeg", userToken: token, objectClass: UpdateProfileModel.self) { response in
            self.delegate?.didReceiveUploadProfileResponse(profileResponse: response)
        }
    }
    func imageUploadAPI(image: UIImage) {
        let token = UserDefaults.standard.string(forKey: UD_TOKEN) ?? ""
        SessionManager.shared.multipartformPostrequest(url: (UrlName.updateProfile + (resultsData?.first?.profileId ?? "")) + "/", method: .put, param: nil, imageKey: "profile_image", image: image, imageName: "file.jpeg", userToken: token, objectClass: UpdateProfileModel.self) { response in
            self.delegate?.didReceiveUploadProfileResponse(profileResponse: response)
        }
    }
    
}
