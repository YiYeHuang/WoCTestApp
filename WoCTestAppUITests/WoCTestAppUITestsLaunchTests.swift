//
//  WoCTestAppUITestsLaunchTests.swift
//  WoCTestAppUITests
//
//  Created by YIYE HUANG on 2025-08-29.
//

import XCTest

final class WoCTestAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Validate app launched successfully
        XCTAssertTrue(app.exists, "App should exist after launch")
        XCTAssertTrue(app.state == .runningForeground, "App should be running in foreground")
        
        // Validate main UI elements are present using correct accessibility properties
        let helloWorldText = app.staticTexts["Hello, world!"]
        XCTAssertTrue(helloWorldText.exists, "Hello, world! text should be visible on launch")
        XCTAssertTrue(helloWorldText.isHittable, "Hello, world! text should be accessible")
        
        // Validate globe image is present
        let globeImage = app.images["globe"]
        XCTAssertTrue(globeImage.exists, "Globe image should be visible on launch")
        XCTAssertEqual(globeImage.label, "Globe", "Globe image should have correct accessibility label")
        
        // Validate text content using value property (SwiftUI uses value instead of label for text content)
        XCTAssertEqual(helloWorldText.value as? String, "Hello, world!", "Text should display correct content in value property")
        
        // Validate that we can find both expected UI elements
        XCTAssertEqual(app.staticTexts.count, 4, "Should have exactly 2 static text elements (app title + hello world)")
        XCTAssertEqual(app.images.count, 1, "Should have exactly 1 image element (globe)")
        
        // Validate app window is present and accessible (instead of app.isHittable which may fail)
        let appWindow = app.windows.firstMatch
        XCTAssertTrue(appWindow.exists, "App window should exist")
        XCTAssertTrue(appWindow.isHittable, "App window should be responsive and hittable")

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
