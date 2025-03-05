//
//  ItemListViewModelTests.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import XCTest
@testable import sport_shooting

@MainActor
final class ItemListViewModelTests: XCTestCase {
    private var userSession: UserSession!
    private var viewModel: ItemListViewModel!
    private var mockItemService: MockItemService!
    
    override func setUp() {
        super.setUp()
        userSession = UserSession()
        mockItemService = MockItemService()
        viewModel = ItemListViewModel()
        viewModel.configure(itemService: mockItemService, userSession: userSession)
    }
    
    override func tearDown() {
        userSession = nil
        mockItemService = nil
        viewModel = nil
        super.tearDown()
    }

    
    func testFetchItemsSuccess() async throws {
        // Preparamos los datos del mock
        let mockItemsResponse = ItemsResponse(
            message: "Ítems recuperados con éxito",
            items: [
                Item(title: "Test Item 1", itemDescription: "Description 1", isPremium: false, type: "free"),
                Item(title: "Test Item 2", itemDescription: "Description 2", isPremium: true, type: "premium")
            ],
            token: "mock_token"
        )
        mockItemService.mockItems = mockItemsResponse.items

        // Ejecutamos la acción
        await viewModel.fetchItems()

        // Verificamos los resultados
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertEqual(viewModel.items[0].title, "Test Item 1")
        XCTAssertEqual(viewModel.items[1].title, "Test Item 2")
    }

    func testFetchItemsFailure() async throws {
        // Forzamos un error
        mockItemService.shouldReturnError = true

        // Ejecutamos la acción
        await viewModel.fetchItems()

        // Verificamos los resultados
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.items.isEmpty)
    }
}
