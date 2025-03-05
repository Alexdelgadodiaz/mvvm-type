//
//  AuthServiceProtocol.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> User
}


