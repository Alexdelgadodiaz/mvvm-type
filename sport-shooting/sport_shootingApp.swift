//
//  sport_shootingApp.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//

import SwiftUI
import SwiftData



@main
struct sport_shootingApp: App {
    @StateObject private var container = AppDependencyContainer.shared
    @StateObject private var userSession = UserSession()

    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environmentObject(userSession)
                .environmentObject(container)
        }
    }
}
