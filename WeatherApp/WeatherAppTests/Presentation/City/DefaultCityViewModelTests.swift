//
//  CityViewModelTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
import SwiftUI
@testable import WeatherApp

final class CityViewModelTests: XCTestCase {
    
    private var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = TestHelpers.makeMockCityWeatherResponseData()
    }

    override func tearDownWithError() throws {
        mockSession = nil
    }

    @MainActor
    func testCityViewModel() async throws {
        // given
        let city = TestHelpers.makeCity()
        
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        let repository = DefaultWeatherRepository(session: mockSession)
        let useCase = DefaultWeatherUseCase(weatherRepository: repository)
        
        let viewModel = DefaultCityViewModel(city: city, weatherUseCase: useCase)
        
        let expectation = TestHelpers.makeCurrentWeather()
        // when
        viewModel.onAppear()
        
        try await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertTrue(viewModel.currentWeather == expectation)
    }
    
    @MainActor
    func testMakeCityViewModel() async throws {
        let scene = Scene()
        let city = TestHelpers.makeCity()
        
        let _ = scene.makeCityViewController(city: city)
        try await Task.sleep(nanoseconds: 100_000_000)
    }
}
