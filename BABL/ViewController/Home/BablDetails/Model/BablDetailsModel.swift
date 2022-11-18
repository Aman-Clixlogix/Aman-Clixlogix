//
//  BablDetailsModel.swift
//  BABL
//
//  Created by Aman Jadhav on 17/11/22.
//

import Foundation

struct BablDetailsModel: Codable {
    var id: String?
    var bablers: [BablDetailsBablers]?
    var welcomeDescription: String?
    var submitBy: Date?
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
struct BablDetailsBablers: Codable {
    var participant: Int?
    var status: String?
}
