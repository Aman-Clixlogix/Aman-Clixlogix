//
//  HomeModel.swift
//  BABL
//

import Foundation


// MARK: - HomeFeed
struct HomeModel: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Result]?
}
// MARK: - Result
struct Result: Codable {
    var id: String?
    var participantCount: Int?
    var ownerProfileImage: String?
    var resultDescription: String?
    var submitBy: String?
    var winnerBy: String?
    var anonymize: Bool?
    var status, createdAt, updatedAt: String?
    var owner: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case participantCount = "participant_count"
        case ownerProfileImage = "owner_profile_image"
        case resultDescription = "description"
        case submitBy = "submit_by"
        case winnerBy = "winner_by"
        case anonymize, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case owner
    }
}
