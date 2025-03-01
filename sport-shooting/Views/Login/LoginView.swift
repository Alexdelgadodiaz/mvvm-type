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

    // Color dinámico para el fondo del formulario
    private var formBackground: Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
            ? UIColor.secondarySystemBackground
            : UIColor.systemGray4
        })
    }
    
    // Color dinámico para el fondo de los textfields
    private var textFieldBackground: Color {
        Color(UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor.systemGray5 // más oscuro para mejorar el contraste en modo oscuro
            } else {
                return UIColor.systemGray6
            }
        })
    }

    var body: some View {
        ZStack {
            // Fondo general adaptable a dark/light mode
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
                        .background(textFieldBackground)
                        .cornerRadius(8)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(textFieldBackground)
                        .cornerRadius(8)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                    Button {
                        Task {
                            await viewModel.login()
                        }
                    } label: {
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
                .background(formBackground)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .accessibilityIdentifier("LoginView")
            .onAppear {
                viewModel.configure(authService: container.authService, userSession: userSession)
            }
        }
    }
}
