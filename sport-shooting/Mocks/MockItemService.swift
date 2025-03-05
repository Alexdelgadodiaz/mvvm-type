//
//  MockItemService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

final class MockItemService: ItemServiceProtocol {

    
    var shouldReturnError = false
    
    private let mockItemsResponse = ItemsResponse(
        message: "Ítems recuperados con éxito",
        items: [
            Item(title: "Mock Item 1", itemDescription: "Description 1", isPremium: false, type: "free"),
            Item(title: "Mock Item 2", itemDescription: "Description 2", isPremium: true, type: "premium")
        ],
        token: "mock_token"
    )
    
    
    func fetchItems(token: String?) async throws -> [Item] {
        if shouldReturnError {
            throw NSError(domain: "MockItemServiceError", code: 500, userInfo: nil)
        }
        return mockItemsResponse.items
    }

}
