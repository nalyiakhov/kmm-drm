//
//  iosAppTests.swift
//  iosAppTests
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import XCTest
@testable import iosApp

final class iosAppTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasEmptyFavorites() {
        let favoriteImages = sharedSettings.favoriteImages
        XCTAssertTrue(!favoriteImages.contains(where: { !$0.isNotBlank() }), "Has empty favorites")
    }

    func testHasMissingImage() {
        for imageName in sharedSettings.favoriteImages {
            XCTAssertNotNil(loadImageFromDisk(fileName: imageName), "Has missing favorite image - \(imageName)")
        }
    }
}
