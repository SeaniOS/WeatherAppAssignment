//
//  CityUseCaseTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

@MainActor
final class CityUseCaseTests: XCTestCase {
    private let searchTerm = TestHelpers.searchTerm
    private var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = TestHelpers.makeMockSearchCitiesResponseData()
    }

    override func tearDownWithError() throws {
        mockSession = nil
    }

    func testSearchCity_StatusCode200() async {
        // given
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        let repository = DefaultCityRepository(session: mockSession)
        let useCase = DefaultCityUseCase(cityRepository: repository)
        
        let expectedCities: [City] = [TestHelpers.makeCity()]
        
        // when
        let cities = await useCase.searchCities(searchTerm: searchTerm)
        
        // then
        XCTAssertEqual(cities, expectedCities)
    }
    
    func testSearchCity_StatusCode400() async {
        // given
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 400)
        let repository = DefaultCityRepository(session: mockSession)
        let useCase = DefaultCityUseCase(cityRepository: repository)
        
        let expectedCities: [City] = []
        
        // when
        let cities = await useCase.searchCities(searchTerm: searchTerm)
        
        // then
        XCTAssertEqual(cities, expectedCities)
    }
}
