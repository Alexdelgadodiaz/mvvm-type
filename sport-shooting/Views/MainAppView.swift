//
//  MainAppView.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var container: AppDependencyContainer


    var body: some View {
        Group {
            if userSession.isLoggedIn == true{
               ItemListView()
                    .environmentObject(container)
                    .environmentObject(userSession)
            } else {
                LoginView()
                    .environmentObject(container)
                    .environmentObject(userSession)
            }
        }
        .accessibilityIdentifier("MainAppView")

    }
}
