//
//  Item.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftData

// Este modelo refleja toda la respuesta
struct ItemsResponse: Decodable {
    let message: String
    let items: [Item]
    let token: String
}

// El modelo de Item queda igual:
@Model
class Item: Decodable {
    var title: String
    var itemDescription: String
    var isPremium: Bool
    var type: String

    init(title: String, itemDescription: String, isPremium: Bool, type: String) {
        self.title = title
        self.itemDescription = itemDescription
        self.isPremium = isPremium
        self.type = type
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.itemDescription = try container.decode(String.self, forKey: .itemDescription)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
        self.type = try container.decode(String.self, forKey: .type)
    }

    private enum CodingKeys: String, CodingKey {
        case title, itemDescription, isPremium, type
    }
}
