//
//  MockAuthService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

final class MockAuthService: AuthServiceProtocol {
    var shouldReturnError = false
    var mockUser = User(username: "test", token: "test")

    func login(username: String, password: String) async throws -> User {
        if shouldReturnError {
            throw NSError(domain: "MockAuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        }

//        guard let user = mockUser else {
//            throw NSError(domain: "MockAuthError", code: 500, userInfo: [NSLocalizedDescriptionKey: "No mock user provided"])
//        }

        return mockUser
    }
}
