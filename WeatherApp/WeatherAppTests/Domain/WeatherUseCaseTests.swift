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

    func testCityWeather_StatusCode200_NoCache() async {
        // given
        let expectation: CurrentWeather = TestHelpers.makeCurrentWeather()
        
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        
        let weatherRepository = DefaultWeatherRepository(session: mockSession)
        let cacheRepository = MockCacheWeatherRepository()
        let useCase = DefaultWeatherUseCase(weatherRepository: weatherRepository, cacheRepository: cacheRepository)
        
        // when
        let result = await useCase.fetchCurrentWeather(latitude: "", longitude: "")
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func testCityWeather_StatusCode200_ValidCache() async {
        // given
        let expectation: CurrentWeather = TestHelpers.makeCacheCurrentWeather()
        
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        
        let weatherRepository = DefaultWeatherRepository(session: mockSession)
        let cacheRepository = makeCacheRepository_ValidCacheItem()
        let useCase = DefaultWeatherUseCase(weatherRepository: weatherRepository, cacheRepository: cacheRepository)
        
        // when
        let result = await useCase.fetchCurrentWeather(latitude: "", longitude: "")
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func testCityWeather_StatusCode200_ExpiredCache() async {
        // given
        let expectation: CurrentWeather = TestHelpers.makeCurrentWeather()
        
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        
        let weatherRepository = DefaultWeatherRepository(session: mockSession)
        let cacheRepository = makeCacheRepository_ExpiredCacheItem()
        let useCase = DefaultWeatherUseCase(weatherRepository: weatherRepository, cacheRepository: cacheRepository)
        
        // when
        let result = await useCase.fetchCurrentWeather(latitude: "", longitude: "")
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func testCityWeather_StatusCode400() async {
        // given
        let expectation: CurrentWeather = .empty
        
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 400)
        
        let weatherRepository = DefaultWeatherRepository(session: mockSession)
        let cacheRepository = MockCacheWeatherRepository()
        let useCase = DefaultWeatherUseCase(weatherRepository: weatherRepository, cacheRepository: cacheRepository)
        
        // when
        let result = await useCase.fetchCurrentWeather(latitude: "", longitude: "")
        
        // then
        XCTAssertEqual(result, expectation)
    }
}

extension WeatherUseCaseTests {
    private func makeCacheRepository_ValidCacheItem() -> MockCacheWeatherRepository {
        let cacheWeatherItem = CacheWeatherItem(timestamp: Date(),
                                                currentWeather: TestHelpers.makeCacheCurrentWeather())
        return MockCacheWeatherRepository(cacheWeatherItem: cacheWeatherItem)
    }
    
    private func makeCacheRepository_ExpiredCacheItem() -> MockCacheWeatherRepository {
        let cacheWeatherItem = CacheWeatherItem(timestamp: Date().addingTimeInterval(-120),
                                                currentWeather: TestHelpers.makeCacheCurrentWeather())
        return MockCacheWeatherRepository(cacheWeatherItem: cacheWeatherItem)
    }
}


