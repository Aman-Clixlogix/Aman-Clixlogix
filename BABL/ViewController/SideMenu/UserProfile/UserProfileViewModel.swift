//
//  UserProfileViewModel.swift
//  BABL
//
//  Created by Aman Jadhav on 18/11/22.
//

import Foundation
import RealmSwift

protocol UserProfileViewModelDelegate: AnyObject {
    func didReceiveUserProfileResponse(profileResponse: UpdateProfileModel)
    func didReceiveGetProfileResponse(profileResponse: UpdateProfileModel)
}

struct UserProfileViewModel {
    var delegate: UserProfileViewModelDelegate?
    let resultsData = try? Realm().objects(UserTable.self)
    func imageUploadAPI(image: UIImage, email: String, pronouns: String) {
        let dic: [String: Any] = ["email": email, "pronouns": pronouns]
        SessionManager.shared.multipartformPostrequest(url: (UrlName.updateProfile + (resultsData?.first?.profileId ?? "")) + "/", method: .put, param: dic, imageKey: "profile_image", image: image, imageName: "file.jpeg", userToken: resultsData?.first?.token ?? "", objectClass: UpdateProfileModel.self) { response in
            self.delegate?.didReceiveUserProfileResponse(profileResponse: response)
        }
    }
    
    func getProfileAPI() {
        SessionManager.shared.multipartformPostrequest(url: (UrlName.updateProfile + (resultsData?.first?.profileId ?? "")) + "/", method: .get, param: nil, imageKey: "file.jpeg", image: nil, imageName: "", userToken: resultsData?.first?.token ?? "", objectClass: UpdateProfileModel.self) { response in
            DispatchQueue.main.async {
                self.delegate?.didReceiveGetProfileResponse(profileResponse: response)
            }
        }
    }
    
    func profileSetupAPI(fullName: String, email: String, location: String, pronouns: String, registrationId: String, bio: String, dob: String, fb: String, twitter: String, linkedin: String, insta: String, privateAccount: Bool) {
        let dic: [String: Any] = [
                   "full_name": fullName,
                   "location": location,
                   "pronouns": pronouns,
                   "email": email,
                   "bio": bio,
                   "birthday": dob,
                   "facebook": fb,
                   "twitter": twitter,
                   "linked_in": linkedin,
                   "instagram": insta,
                   "registration_id": registrationId,
                   "private_account": privateAccount
                   ]
        let token = UserDefaults.standard.string(forKey: UD_TOKEN) ?? ""
        SessionManager.shared.multipartformPostrequest(url: (UrlName.updateProfile + (resultsData?.first?.profileId ?? "")) + "/", method: .put, param: dic, imageKey: "file.jpeg", image: nil, imageName: "", userToken: token, objectClass: UpdateProfileModel.self) { response in
            self.delegate?.didReceiveUserProfileResponse(profileResponse: response)
        }
    }
    
}

