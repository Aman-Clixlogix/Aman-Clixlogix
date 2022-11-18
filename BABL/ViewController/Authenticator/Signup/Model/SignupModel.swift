//
//  SignupModel.swift
//  BABL
//

import Foundation

struct SignupModel: Codable {
    var id: Int?
    var firstName, lastName, username, email: String?
    var profileID, token: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email
        case profileID = "profile_id"
        case token
    }
}
