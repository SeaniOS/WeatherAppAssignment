//
//  WeatherResponseTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
@testable import WeatherApp

final class WeatherResponseTests: XCTestCase {
    func testConvertToCities() {
        // given
        let response = TestHelpers.makeWeatherResponse()
        let expectedWeather: CurrentWeather = TestHelpers.makeCurrentWeather()
        
        // when
        let currentWeather = response.toCurrentWeather()
        
        // then
        XCTAssertEqual(currentWeather, expectedWeather)
    }
}
