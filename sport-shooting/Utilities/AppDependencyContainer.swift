//
//  AppDependencyContainer.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//
import SwiftUI

enum Environment {
    case production
    case mock
}

final class AppDependencyContainer: ObservableObject {
    static let shared = AppDependencyContainer()

    private let environment: Environment

    private let networkClient: NetworkClient
    //Para avanzar con mocks seteamos .mock
    init(environment: Environment = .mock) {
        self.environment = environment
        self.networkClient = URLSessionNetworkClient(baseURL: "https://api.example.com")
    }

    var authService: AuthServiceProtocol {
        switch environment {
        case .production:
            return AuthService(networkClient: networkClient)
        case .mock:
            return MockAuthService()
        }
    }

    var itemService: ItemServiceProtocol {
        switch environment {
        case .production:
            return ItemService(networkClient: networkClient)
        case .mock:
            return MockItemService()
        }
    }
}
