//
//  WeatherUseCaseTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
@testable import WeatherApp

@MainActor
final class WeatherUseCaseTests: XCTestCase {
    private var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = TestHelpers.makeMockCityWeatherResponseData()
    }

    override func tearDownWithError() throws {
        mockSession = nil
    }

    func testCityWeather_StatusCode200() async {
        // given
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        let repository = DefaultWeatherRepository(session: mockSession)
        let useCase = DefaultWeatherUseCase(weatherRepository: repository)
        
        let expectation: CurrentWeather = TestHelpers.makeCurrentWeather()
        
        // when
        let result = await useCase.fetchCurrentWeather(latitude: "", longitude: "")
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func testCityWeather_StatusCode400() async {
        // given
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 400)
        let repository = DefaultWeatherRepository(session: mockSession)
        let useCase = DefaultWeatherUseCase(weatherRepository: repository)
        
        let expectation: CurrentWeather = .empty
        
        // when
        let result = await useCase.fetchCurrentWeather(latitude: "", longitude: "")
        
        // then
        XCTAssertEqual(result, expectation)
    }
}
