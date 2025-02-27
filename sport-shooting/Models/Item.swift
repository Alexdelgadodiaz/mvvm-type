//
//  Item.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftData

@Model
class Item: Decodable {
    var title: String
    var itemDescription: String

    // El inicializador personalizado no afecta la conformidad a Decodable directamente
    init(title: String, itemDescription: String) {
        self.title = title
        self.itemDescription = itemDescription
    }

    // Este inicializador es necesario para Decodable si usas @Model
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.itemDescription = try container.decode(String.self, forKey: .itemDescription)
    }

    // Definir las claves que coinciden con las propiedades
    private enum CodingKeys: String, CodingKey {
        case title, itemDescription
    }
}
