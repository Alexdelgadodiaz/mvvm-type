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
            return "Invalid email or password."
        case .userNotFound:
            return "User not found."
        }
    }
}

final class MockAuthService: AuthServiceProtocol {
    // Simulamos un diccionario de usuarios válidos con sus datos
    private let validUsers: [String: (password: String, name: String, role: String, isActive: Bool, isPremium: Bool)] = [
        "test@example.com": (password: "pass", name: "Test User", role: "user", isActive: true, isPremium: false),
        "admin@example.com": (password: "adminpass", name: "Admin User", role: "admin", isActive: true, isPremium: true)
    ]
    
    var mockUser: User?

    func login(email: String, password: String) async throws -> User {
        guard let storedData = validUsers[email] else {
            throw AuthError.userNotFound
        }
        
        guard storedData.password == password else {
            throw AuthError.invalidCredentials
        }

        let user = User(
            name: storedData.name,
            email: email,
            role: storedData.role,
            isActive: storedData.isActive,
            isPremium: storedData.isPremium,
            token: "mock_token_\(UUID().uuidString)"
        )
        self.mockUser = user
        return user
    }
}
