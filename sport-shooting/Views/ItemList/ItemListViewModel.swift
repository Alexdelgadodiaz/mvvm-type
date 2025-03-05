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
    @Published var isLoading: Bool = false

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
        guard let token = userSession.currentUser?.token else {
            await MainActor.run {
                self.errorMessage = "User is not authenticated."
                userSession.logoutUser()
            }
            return
        }
        
        await MainActor.run { self.isLoading = true }
        
        do {
            let fetchedItems = try await itemService.fetchItems(token: token)
            await MainActor.run {
                self.items = fetchedItems
                self.errorMessage = nil
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error fetching items: \(error.localizedDescription)"
                self.isLoading = false 
            }
        }
    }
}
