//
//  NetworkClient.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import Foundation

protocol NetworkClient {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?
    ) async throws -> T
}

final class URLSessionNetworkClient: NetworkClient {
    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) async throws -> T {
        let maxRetries = 3
        var attempt = 0
        var lastError: Error?

        while attempt < maxRetries {
            do {
                return try await performRequest(endpoint: endpoint, method: method, headers: headers, body: body)
            } catch {
                lastError = error
                attempt += 1
            }
        }

        throw lastError ?? URLError(.unknown)
    }

    private func performRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?
    ) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Respuesta del servidor: \(jsonString)")
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
