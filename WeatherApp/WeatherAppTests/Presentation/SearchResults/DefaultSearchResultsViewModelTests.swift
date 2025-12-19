//
//  DefaultSearchResultsViewModelTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp
internal import Combine

@MainActor
final class DefaultSearchResultsViewModelTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()
    private let searchTerm = TestHelpers.searchTerm
    private var mockSession: MockURLSession!
    
    // MARK: - Test Life cycle
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        mockSession.data = TestHelpers.makeMockSearchCitiesResponseData()
    }
    
    override func tearDownWithError() throws {
        subscriptions = []
        mockSession = nil
    }
    
    // MARK: Unit tests
    func testSearchCities_StatusCode200() async throws {
        // given
        mockSession.urlResponse = TestHelpers.makeMockURLResponse(statusCode: 200)
        let repository = DefaultCityRepository(session: mockSession)
        let useCase = DefaultCityUseCase(cityRepository: repository)
        let viewModel = DefaultSearchResultsViewModel(cityUseCase: useCase)
        
        let expectedCities = [TestHelpers.makeCity()]
        var searchedCities = [City]()
        
        viewModel.searchedCitiesPublisher // $searchedCities
            .dropFirst()
            .sink(receiveValue: { value in
                searchedCities = value
            })
            .store(in: &subscriptions)
        
        // when
        viewModel.searchTermSubject.send(searchTerm)
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // then
        XCTAssertEqual(searchedCities, expectedCities)
    }
}
