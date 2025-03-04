//
//  AuthService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

final class AuthService: AuthServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func login(email: String, password: String) async throws -> User {

        let body = ["email": email, "password": password]
        let bodyData = try JSONEncoder().encode(body)

        let user: User = try await networkClient.request(
            endpoint: "/api/login",
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: bodyData
        )

        return user
    }
}
