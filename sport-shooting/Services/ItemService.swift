//
//  ItemService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

final class ItemService: ItemServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchItems() async throws -> [Item] {
        return try await networkClient.request(
            endpoint: "/items",
            method: .get,
            headers: nil,
            body: nil
        )
    }

    func addItem(title: String, description: String) async throws {
        let body = ["title": title, "description": description]
        let bodyData = try JSONEncoder().encode(body)

        let _: Item = try await networkClient.request(
            endpoint: "/items",
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: bodyData
        )
    }

    func deleteItem(item: Item) async throws {
        let _: Item = try await networkClient.request(
            endpoint: "/items/\(item.id)",
            method: .delete,
            headers: nil,
            body: nil
        )
    }
}
