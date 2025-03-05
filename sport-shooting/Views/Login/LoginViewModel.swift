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
    @Published var isLoading: Bool = false 

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
        
        await MainActor.run { isLoading = true }

        do {
            let user = try await authService.login(email: email, password: password)
            
            guard let token = user.token else {
                await MainActor.run {
                    self.errorMessage = "Login successful, but no token received."
                    self.isLoading = false
                }
                return
            }
            
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
                self.isLoading = false // Detener el indicador de carga al finalizar
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false // Detener el indicador de carga si ocurre un error
            }
        }
    }
}
