//
//  User.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftData

@Model
class User: Decodable {
    var username: String
    var token: String

    // El inicializador personalizado no afecta la conformidad a Decodable directamente
    init(username: String, token: String) {
        self.username = username
        self.token = token
    }

    // Este inicializador es necesario para Decodable si usas @Model
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.token = try container.decode(String.self, forKey: .token)
    }

    // Definir las claves que coinciden con las propiedades
    private enum CodingKeys: String, CodingKey {
        case username, token
    }
}
