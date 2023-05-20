//
//  iosAppUITests.swift
//  iosAppUITests
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import XCTest

final class iosAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        let generatorButton = app.buttons["Генератор изображений"]
        XCTAssertTrue(generatorButton.exists, "Unable to find Generator button")
        generatorButton.tap()
        
        let generatorTextField = app.textFields["Введите запрос"]
        XCTAssertTrue(generatorTextField.exists, "Unable to find Query text field")
        generatorTextField.tap()
        generatorTextField.typeText("Test text")
        
        let generateButton = app.buttons["Сгенерировать"]
        XCTAssertTrue(generateButton.exists, "Unable to find Generate button")
        generateButton.tap()

        let favoriteButton = app.buttons["star"]
        XCTAssertTrue(favoriteButton.exists, "Unable to find Favorite button")
        favoriteButton.tap()

        let favoritesTabButton = app.buttons["Избранное"]
        XCTAssertTrue(favoritesTabButton.exists, "Unable to find Favorites tab button")
        favoritesTabButton.tap()
        
        let noImagesLabel = app.staticTexts["Нет избранных изображений"]
        XCTAssertTrue(!noImagesLabel.exists, "Favorites is empty")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
