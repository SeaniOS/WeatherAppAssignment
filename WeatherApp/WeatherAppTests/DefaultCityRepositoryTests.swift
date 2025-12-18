//
//  DefaultCityRepositoryTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return (data ?? Data(), urlResponse ?? URLResponse())
    }
}

final class DefaultCityRepositoryTests: XCTestCase {
    private let searchTerm = "hanoi"
    private var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = makeMockData()
    }
    
    override func tearDownWithError() throws {
        mockSession = nil
    }
    
    @MainActor
    func testSearchCities_StatusCode200() async throws {
        //
        mockSession.urlResponse = makeMockResponse(statusCode: 200)
        let repository = DefaultCityRepository(session: mockSession)
        
        //
        let response = try await repository.searchCities(searchTerm: searchTerm)
        
        //
        XCTAssertEqual(response, makeExpectedSearchCityResponse())
    }
    
    func testSearchCities_StatusCode400() async throws {
        //
        mockSession.urlResponse = makeMockResponse(statusCode: 400)
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

extension DefaultCityRepositoryTests {
    private func makeMockData() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let jsonURL = bundle.url(forResource: "SearchCitiesDummyResponse", withExtension: ".json") else {
            fatalError("no json file")
        }
        
        let mockData = try? Data(contentsOf: jsonURL)
        return mockData
    }
    
    private func makeMockResponse(statusCode: Int) -> HTTPURLResponse? {
        return HTTPURLResponse(url: URL(string: APIConstants.searchURLString)!,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: nil)
    }
    
    private func makeExpectedSearchCityResponse() -> SearchCityResponse {
        let name = Value(value: "Hanoi")
        let country = Value(value: "Vietnam")
        let city: CityResponse = .init(areaName: [name], country: [country], latitude: "21.033", longitude: "105.850")
        return .init(searchAPI: .init(cities: [city]))
    }
}
