//
//  LoginViewModel.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    
    var authService: AuthServiceProtocol!
    var userSession: UserSession!
    
    func configure(authService: AuthServiceProtocol, userSession: UserSession) {
        self.authService = authService
        self.userSession = userSession
    }

    func login() async {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Username and password are required."
            return
        }

        do {
            let user = try await authService.login(username: username, password: password)
            print(user.username, user.token)
            
            await MainActor.run {
                userSession.loginUser(username: user.username, token: user.token)
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
