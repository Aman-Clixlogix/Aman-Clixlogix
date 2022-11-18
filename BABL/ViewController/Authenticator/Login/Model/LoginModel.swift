//
//  LoginModel.swift
//  BABL
//

import Foundation


// MARK: - Login
struct LoginModel: Codable {
    var userID: Int?
    var email, firstName, lastName, profileID: String?
    var profileImage, inviteCode, token: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case profileID = "profile_id"
        case profileImage = "profile_image"
        case inviteCode = "invite_code"
        case token
    }
}
