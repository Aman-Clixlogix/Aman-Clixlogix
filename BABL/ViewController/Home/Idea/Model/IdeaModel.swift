//
//  IdeaModel.swift
//  BABL
//

import Foundation


// MARK: - IdeaModel
struct IdeaModel: Codable {
    var id: String?
    var bablers: [Babler]?
    var welcomeDescription: String?
    var submitBy: String?
    var winnerBy: String?
    var anonymize: Bool?
    var status, createdAt, updatedAt: String?
    var owner: Int?

    enum CodingKeys: String, CodingKey {
        case id, bablers
        case welcomeDescription = "description"
        case submitBy = "submit_by"
        case winnerBy = "winner_by"
        case anonymize, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case owner
    }
}

// MARK: - Babler
struct Babler: Codable {
    var participant: Participant?
    var status: String?
}

// MARK: - Participant
struct Participant: Codable {
    var id: Int?
    var full_name: String?
    var profile_image: String?
    var username: String?
    var profile: Profile?
}

// MARK: - Profile
struct Profile: Codable {
    var fullName: String?
    var username: String?
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case username
        case profileImage = "profile_image"
    }
}

