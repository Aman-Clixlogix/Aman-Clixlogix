//
//  BablSettingModel.swift
//  BABL
//

import Foundation

// MARK: - Babl Setting Model
struct BablSettingModel: Codable {
    var id, welcomeDescription: String?
    var submitBy: String?
    var winnerBy: String?
    var anonymize: Bool?
    var status, createdAt, updatedAt: String?
    var owner: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case welcomeDescription = "description"
        case submitBy = "submit_by"
        case winnerBy = "winner_by"
        case anonymize, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case owner
    }
}
