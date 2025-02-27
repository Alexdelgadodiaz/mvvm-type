//
//  ItemListViewModel.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//

import SwiftUI

final class ItemListViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var errorMessage: String?

    var itemService: ItemServiceProtocol!
    var userSession: UserSession!
    
    func configure(itemService: ItemServiceProtocol, userSession: UserSession) {
        self.itemService = itemService
        self.userSession = userSession
    }

    func logout() {
        userSession.logoutUser()
    }
    
    func fetchItems() async {
        
        do {
            let fetchedItems = try await itemService.fetchItems()
            await MainActor.run {
                self.items = fetchedItems
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error fetching items: \(error.localizedDescription)"

            }
        }
        
    }
}
