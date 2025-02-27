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

    func loginUser(username: String, token: String) {
        currentUser = User(username: username, token: token)
        isLoggedIn = true
    }

    func logoutUser() {
        currentUser = nil
        isLoggedIn = false

    }
}
