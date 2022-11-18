//
//  PrivacyPolicyModel.swift
//  BABL
//

import Foundation


// MARK: - Privacy Policy
struct PrivacyPolicyModel: Codable {
    var id, slug, title, content: String?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, title, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
