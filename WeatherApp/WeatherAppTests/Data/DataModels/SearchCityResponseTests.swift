//
//  SearchCityResponseTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

final class SearchCityResponseTests: XCTestCase {
    func testConvertToCities() {
        // given
        let response = TestHelpers.makeSearchCityResponse()
        let expectedCities: [City] = [TestHelpers.makeCity()]
        
        // when
        let cities = response.toCities()
        
        // then
        XCTAssertEqual(cities, expectedCities)
    }
    
    func testConvertToCities_MissingName() {
        // given
        let response = TestHelpers.makeSearchCityResponse_MissingAreaName()
        let expectedCities: [City] = []
        
        // when
        let cities = response.toCities()
        
        // then
        XCTAssertEqual(cities, expectedCities)
    }
    
    func testConvertToCities_MissingCountry() {
        // given
        let response = TestHelpers.makeSearchCityResponse_MissingCountry()
        let expectedCities: [City] = [TestHelpers.makeCity(country: "")]
        
        // when
        let cities = response.toCities()
        
        // then
        XCTAssertEqual(cities, expectedCities)
    }
}
