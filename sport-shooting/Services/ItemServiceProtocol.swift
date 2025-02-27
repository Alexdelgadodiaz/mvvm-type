//
//  ItemServiceProtocol.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


protocol ItemServiceProtocol {
    func fetchItems() async throws -> [Item]
    func addItem(title: String, description: String) async throws
    func deleteItem(item: Item) async throws
}