//
//  AppDependencyContainer.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//
import SwiftUI

enum Environment {
    case production
    case staging
    case mock
}

final class AppDependencyContainer: ObservableObject {
    static let shared = AppDependencyContainer()

    private let environment: Environment
    private let serviceBuilder: ServiceBuilder

    private init() {
        #if DEBUG
        let environment: Environment = .mock
        #elseif RELEASE
        let environment: Environment = .production
        #else
        let environment: Environment = .staging
        #endif

        self.environment = environment
        let baseURL = AppDependencyContainer.baseURL(for: environment)
        let networkClient = URLSessionNetworkClient(baseURL: baseURL)
        self.serviceBuilder = ServiceBuilder(environment: environment, networkClient: networkClient)
    }

    private static func baseURL(for environment: Environment) -> String {
        switch environment {
        case .production:
            return "http://localhost:3000"
        case .staging:
            return "http://localhost:3000"
        case .mock:
            return "local"
        }
    }

    func authService() -> AuthServiceProtocol {
        return serviceBuilder.buildAuthService()
    }

    func itemService(token: String?) -> ItemServiceProtocol {
        return serviceBuilder.buildItemService(token: token)
    }
    
}



