//
//  MockItemService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

final class MockItemService: ItemServiceProtocol {

    
    var shouldReturnError = false
    var mockItems: [Item] = [
        Item(title: "Mock Item 1", itemDescription: "Description 1", isPremium: false, type: "free"),
        Item(title: "Mock Item 2", itemDescription: "Description 2", isPremium: true, type: "premium")
    ]
    
    func fetchItems(token: String?) async throws -> [Item] {
        if shouldReturnError {
            throw NSError(domain: "MockItemServiceError", code: 500, userInfo: nil)
        }
        return mockItems
    }

    func addItem(title: String, description: String, isPremium: Bool, type: String) async throws {
        if shouldReturnError {
            throw NSError(domain: "MockItemServiceError", code: 500, userInfo: nil)
        }
        let newItem = Item(title: title, itemDescription: description, isPremium: isPremium, type: type)
        mockItems.append(newItem)
    }

    func deleteItem(item: Item) async throws {
        if shouldReturnError {
            throw NSError(domain: "MockItemServiceError", code: 500, userInfo: nil)
        }
        mockItems.removeAll { $0 === item }
    }
}
