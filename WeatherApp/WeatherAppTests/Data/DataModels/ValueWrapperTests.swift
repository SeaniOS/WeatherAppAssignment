//
//  ValueWrapperTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
@testable import WeatherApp

final class ValueWrapperTests: XCTestCase {
    func testValueWrapper() {
        let array: [ValueWrapper] = []
        XCTAssertEqual(array.firstValue, "")
    }
}
