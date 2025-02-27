//
//  LoginView.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var container: AppDependencyContainer

    @StateObject private var viewModel = LoginViewModel()


    var body: some View {
        ZStack {
            // Fondo general
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.login()
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .onAppear {
                viewModel.configure(authService: container.authService, userSession: userSession)
            }
        }
    }
}
