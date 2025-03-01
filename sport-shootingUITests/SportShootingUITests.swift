//
//  SportShootingUITests.swift
//  sport-shooting
//
//  Created by AlexDelgado on 1/3/25.
//


import XCTest

final class SportShootingUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        performLoginIfNeeded()
    }

    func performLoginIfNeeded() {
        let loginButton = app.buttons["Login"]
        if loginButton.exists { // Si la pantalla de login está visible, hacemos login
            let usernameField = app.textFields["Username"]
            let passwordField = app.secureTextFields["Password"]
            
            usernameField.tap()
            usernameField.typeText("test")

            passwordField.tap()
            passwordField.typeText("pass")
            
            loginButton.tap()

            let mainView = app.otherElements["MainAppView"]
            XCTAssertTrue(mainView.waitForExistence(timeout: 2))
        }
    }

    func testItemListDisplays() throws {
        print(app.debugDescription)

        let itemScrollView = app.scrollViews["ItemsScrollView"]
        XCTAssertTrue(itemScrollView.waitForExistence(timeout: 2), "The itemScrollView view should exist")
    }
    
    func testNavigationToItemDetail() throws {
        
        let itemsScrollView = app.scrollViews["ItemsScrollView"]
        XCTAssertTrue(itemsScrollView.waitForExistence(timeout: 2), "The itemsScrollView view should exist")
        
        
        let firstButton = itemsScrollView.buttons.firstMatch
        XCTAssertTrue(firstButton.exists, "The first button should be visible")
        
        firstButton.tap()
        print(app.debugDescription)

        let ItemDetailView = app.scrollViews["ItemDetailView"]
        XCTAssertTrue(ItemDetailView.waitForExistence(timeout: 5), "The ItemDetailView view should exist")

    }
}
