//
//  ItemServiceProtocol.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


protocol ItemServiceProtocol {
    func fetchItems(token: String?) async throws -> [Item]
}
