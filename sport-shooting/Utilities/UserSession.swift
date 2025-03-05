//
//  UserSession.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftData
import SwiftUI

final class UserSession: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false

    func loginUser(name: String, email: String, role: String, isActive: Bool, isPremium: Bool, token: String) {
        // Crear el usuario con todas las propiedades disponibles
        currentUser = User(name: name, email: email, role: role, isActive: isActive, isPremium: isPremium, token: token)
        isLoggedIn = true
    }

    func logoutUser() {
        // Borrar la información de usuario al cerrar sesión
        currentUser = nil
        isLoggedIn = false
    }
}

