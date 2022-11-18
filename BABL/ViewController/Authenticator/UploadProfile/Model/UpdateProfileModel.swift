//
//  UpdateProfileModel.swift
//  BABL
//

import Foundation

struct UpdateProfileModel: Codable {
    var id, user, fullName, username: String?
    var location, email, pronouns, bio: String?
    var birthday: String?
    var phone_number: Int?
    var profileImage: String?
    var inviteCode: String?
    var facebook, twitter, linkedIn, instagram: String?
    var privateAccount: Bool?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, user
        case phone_number
        case fullName = "full_name"
        case username, location, email, pronouns, bio, birthday
        case profileImage = "profile_image"
        case inviteCode = "invite_code"
        case facebook, twitter
        case linkedIn = "linked_in"
        case instagram
        case privateAccount = "private_account"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
