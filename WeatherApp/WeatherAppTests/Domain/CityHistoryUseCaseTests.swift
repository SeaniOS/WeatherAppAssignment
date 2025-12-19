//
//  CityHistoryUseCaseTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 20/12/25.
//

import XCTest
@testable import WeatherApp
internal import CoreData

@MainActor
final class CityHistoryUseCaseTests: XCTestCase {
    func testSaveCityHistory_UpdateTimestamp() async throws {
        // given
        let city = TestHelpers.makeCity()
        
        let repository = DefaultCityHistoryRepository(context: CoreDataStack.shared.testContainer.viewContext)
        let useCase = DefaultCityHistoryUseCase(cityHistoryRepository: repository)
        
        useCase.saveCityHistory(city: city) // add
        try await Task.sleep(nanoseconds: 100_000_000)
        // when
        useCase.saveCityHistory(city: city) // update
    }
}
