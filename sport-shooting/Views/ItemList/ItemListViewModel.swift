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
        // Asegurarse de que el usuario esté autenticado y tenga un token válido
        guard let token = userSession.currentUser?.token else {
            await MainActor.run {
                self.errorMessage = "User is not authenticated."
                userSession.logoutUser()
            }
            return
        }
        
        do {
            // Pasar el token al servicio de ítems si es necesario
            let fetchedItems = try await itemService.fetchItems(token: token)
            
            print(fetchedItems.first!)
            
            await MainActor.run {
                self.items = fetchedItems
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error fetching items: \(error.localizedDescription)"
            }
        }
    }
}
