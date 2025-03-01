//
//  MockAuthService.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid username or password."
        case .userNotFound:
            return "User not found."
        }
    }
}

final class MockAuthService: AuthServiceProtocol {
    private let validUsers: [String: String] = [
        "test": "pass"
    ]
    
    var mockUser: User?

    func login(username: String, password: String) async throws -> User {
        guard let storedPassword = validUsers[username] else {
            throw AuthError.userNotFound
        }
        
        guard storedPassword == password else {
            throw AuthError.invalidCredentials
        }

        let user = User(username: username, token: "mock_token_\(UUID().uuidString)")
        self.mockUser = user
        return user
    }
}
