//
//  ProfileSetupViewMode.swift
//  BABL
//

import Foundation
import RealmSwift

protocol ProfileSetupViewModelDelegate: AnyObject {
    func didReceiveProfileSetupResponse(profileResponse: ProfileSetupModel)
}

struct ProfileSetupViewModel {
    var delegate: ProfileSetupViewModelDelegate?
    let resultsData = try? Realm().objects(UserTable.self)
    func profileSetupAPI(userName: String, fullName: String, email: String, location: String, pronouns: String, countryCode: String, phone: String, registrationId: String, bio: String, dob: String, fb: String, twitter: String, linkedin: String, insta: String) {
        let dic = ["username": userName,
                   "full_name": fullName,
                   "email": email,
                   "location": location,
                   "pronouns": pronouns,
                   "country_code": countryCode,
                   "phone_number": phone,
                   "bio": bio,
                   "birthday": dob,
                   "facebook": fb,
                   "twitter": twitter,
                   "linked_in": linkedin,
                   "instagram": insta,
                   "registration_id": registrationId]
        let token = UserDefaults.standard.string(forKey: UD_TOKEN) ?? ""
        SessionManager.shared.multipartformPostrequest(url: (UrlName.updateProfile + (resultsData?.first?.profileId ?? "")) + "/", method: .put, param: dic, imageKey: "file.jpeg", image: nil, imageName: "", userToken: token, objectClass: ProfileSetupModel.self) { response in
            self.delegate?.didReceiveProfileSetupResponse(profileResponse: response)
        }
    }
}
