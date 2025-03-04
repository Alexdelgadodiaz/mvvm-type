//
//  ItemService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

struct Response: Decodable {
    let message: String
    let items: [Item]
    let token: String
}

final class ItemService: ItemServiceProtocol {

    private let networkClient: NetworkClient
    private let token: String
    
    init(networkClient: NetworkClient, token: String) {
        self.networkClient = networkClient
        self.token = token
    }
    
    func fetchItems(token: String?) async throws -> [Item] {
        // Asegurarse de que el token no sea nulo
        guard let token = token, !token.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }

        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        // Aquí obtienes los datos crudos de la respuesta
        let response: Response = try await networkClient.request(
            endpoint: "/api/items",
            method: .get,
            headers: headers,
            body: nil
        )
        
        // Devuelve solo el array de items
        return response.items
    }
    

}
