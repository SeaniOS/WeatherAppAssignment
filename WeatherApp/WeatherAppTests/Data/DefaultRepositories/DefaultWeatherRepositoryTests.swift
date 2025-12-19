//
//  DefaultWeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
@testable import WeatherApp

final class DefaultWeatherRepositoryTests: XCTestCase {
    private var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = TestHelpers.makeMockCityWeatherResponseData()
    }
    
    override func tearDownWithError() throws {
        mockSession = nil
    }
    
    @MainActor
    func testCityWeather_StatusCode200() async throws {
        //
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        let repository = DefaultWeatherRepository(session: mockSession)
        
        //
        let response = try await repository.fetchCurrentWeather(latitude: "", longitude: "")
        
        //
        XCTAssertEqual(response, TestHelpers.makeWeatherResponse())
    }
    
    func testCityWeather_StatusCode400() async throws {
        //
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 400)
        let repository = await DefaultWeatherRepository(session: mockSession)
        
        //
        do {
            _ = try await repository.fetchCurrentWeather(latitude: "", longitude: "")
        } catch {
            //
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
}
