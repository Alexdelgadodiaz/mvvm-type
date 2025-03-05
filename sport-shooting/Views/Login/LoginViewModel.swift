//
//  LoginViewModel.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email: String = "test@example.com"
    @Published var password: String = "pass"
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    
    var authService: AuthServiceProtocol!
    var userSession: UserSession!
    
    func configure(authService: AuthServiceProtocol, userSession: UserSession) {
        self.authService = authService
        self.userSession = userSession
    }

    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required."
            return
        }

        do {
            let user = try await authService.login(email: email, password: password)
            
            // Chequeo de token opcional
            guard let token = user.token else {
                await MainActor.run {
                    self.errorMessage = "Login successful, but no token received."
                }
                return
            }
            
            // Aquí se reflejan los nuevos campos del usuario
            print(user.email, user.name, user.role, user.isPremium, token)
            
            await MainActor.run {
                userSession.loginUser(
                    name: user.name,
                    email: user.email,
                    role: user.role,
                    isActive: user.isActive,
                    isPremium: user.isPremium,
                    token: token
                )
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
