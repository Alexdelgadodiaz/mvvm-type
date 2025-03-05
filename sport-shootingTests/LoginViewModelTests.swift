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
        // Configuramos credenciales correctas
        viewModel.email = "test@example.com"
        viewModel.password = "pass"

        // Ejecutamos el login
        await viewModel.login()

        print("Username after login: \(String(describing: userSession.currentUser?.email))")

        // Verificamos que el usuario está autenticado correctamente
        XCTAssertEqual(userSession.currentUser!.name, "Test User")
        XCTAssertTrue(userSession.isLoggedIn)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoginFailure() async throws {

        viewModel.email = "test@example.com"
        viewModel.password = "wrongPassword"

        await viewModel.login()

        XCTAssertFalse(userSession.isLoggedIn)

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, AuthError.invalidCredentials.localizedDescription)
    }
}
