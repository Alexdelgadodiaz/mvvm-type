//
//  ServiceBuilder.swift
//  sport-shooting
//
//  Created by AlexDelgado on 4/3/25.
//


final class ServiceBuilder {
    private let environment: Environment
    private let networkClient: NetworkClient

    init(environment: Environment, networkClient: NetworkClient) {
        self.environment = environment
        self.networkClient = networkClient
    }

    func buildAuthService() -> AuthServiceProtocol {
        switch environment {
        case .production:
            return AuthService(networkClient: networkClient)
        case .staging:
            return AuthService(networkClient: networkClient)
        case .mock:
            return MockAuthService()
        }
    }

    func buildItemService(token: String?) -> ItemServiceProtocol {
        switch environment {
        case .production:
            return ItemService(networkClient: networkClient, token: ensureTokenExists(token))
        case .staging:
            return ItemService(networkClient: networkClient, token: ensureTokenExists(token))
        case .mock:
            return MockItemService()
        }
    }

    private func ensureTokenExists(_ token: String?) -> String {
        guard let validToken = token else {
            fatalError("Token is required for production services.")
        }
        return validToken
    }
}
