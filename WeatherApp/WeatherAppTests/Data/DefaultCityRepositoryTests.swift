//
//  DefaultCityRepositoryTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

final class DefaultCityRepositoryTests: XCTestCase {
    private let searchTerm = TestHelpers.searchTerm
    private var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = TestHelpers.makeMockSearchCitiesResponseData()
    }
    
    override func tearDownWithError() throws {
        mockSession = nil
    }
    
    @MainActor
    func testSearchCities_StatusCode200() async throws {
        //
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        let repository = DefaultCityRepository(session: mockSession)
        
        //
        let response = try await repository.searchCities(searchTerm: searchTerm)
        
        //
        XCTAssertEqual(response, TestHelpers.makeSearchCityResponse())
    }
    
    func testSearchCities_StatusCode400() async throws {
        //
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 400)
        let repository = await DefaultCityRepository(session: mockSession)
        
        //
        do {
            _ = try await repository.searchCities(searchTerm: searchTerm)
        } catch {
            //
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
}
