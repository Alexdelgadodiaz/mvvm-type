//
//  User.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftData

@Model
class User: Decodable {
    var name: String
    var email: String
    var role: String
    var isActive: Bool
    var isPremium: Bool
    var token: String?

    // El inicializador personalizado no afecta la conformidad a Decodable directamente
    init(name: String, email: String, role: String, isActive: Bool, isPremium: Bool, token: String?) {
        self.name = name
        self.email = email
        self.role = role
        self.isActive = isActive
        self.isPremium = isPremium
        self.token = token
    }

    // Este inicializador es necesario para Decodable si usas @Model
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.role = try container.decode(String.self, forKey: .role)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
    }

    // Definir las claves que coinciden con las propiedades
    private enum CodingKeys: String, CodingKey {
        case name, email, role, isActive, isPremium, token
    }
}
