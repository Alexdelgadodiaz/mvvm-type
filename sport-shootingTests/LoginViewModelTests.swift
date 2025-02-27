//
//  LoginViewModelTests.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import XCTest
@testable import sport_shooting

final class LoginViewModelTests: XCTestCase {
    private var userSession: UserSession!
    private var viewModel: LoginViewModel!
    private var mockAuthService: MockAuthService!

    override func setUp() {
        super.setUp()
        userSession = UserSession()
        mockAuthService = MockAuthService()
        viewModel = LoginViewModel()
        viewModel.configure(authService: mockAuthService, userSession: userSession)
    }

    override func tearDown() {
        userSession = nil
        mockAuthService = nil
        viewModel = nil
        super.tearDown()
    }

    func testLoginSuccess() async throws {
        // Preparamos el mock
        mockAuthService.mockUser = User(username: "test", token: "test")

        // Configuramos las entradas
        viewModel.username = "test"
        viewModel.password = "test"

        // Ejecutamos el login
        await viewModel.login()

        print(viewModel.username)
        // Verificamos los resultados
        XCTAssertEqual(userSession.currentUser?.username, "test")
        XCTAssertTrue(userSession.isLoggedIn)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoginFailure() async throws {
        // Forzamos un error
        mockAuthService.shouldReturnError = true

        // Configuramos las entradas
        viewModel.username = "test"
        viewModel.password = "wrongPassword"

        // Ejecutamos el login
        await viewModel.login()

        // Verificamos los resultados
        XCTAssertFalse(userSession.isLoggedIn)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
