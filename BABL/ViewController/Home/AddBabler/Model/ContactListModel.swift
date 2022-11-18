//
//  ContactListModel.swift
//  BABL
//

import Foundation


// MARK: - Welcome
struct ContactListmodel: Codable {
    var installed: [[Installed]]?
}

// MARK: - Installed
struct Installed: Codable {
    var user: Int?
    var fullName, profileImage, countryCode: String?
    var phoneNumber: Int?

    enum CodingKeys: String, CodingKey {
        case user
        case fullName = "full_name"
        case profileImage = "profile_image"
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
    }
}
