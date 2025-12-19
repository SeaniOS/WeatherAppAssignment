//
//  ImageHandlerTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
@testable import WeatherApp

final class ImageHandlerTests: XCTestCase {
    func testImageHandler_InvalidURL() async throws {
        let image = try await ImageHandler().loadImage(urlString: "https://google.com ")
        XCTAssertNil(image)
    }

}
