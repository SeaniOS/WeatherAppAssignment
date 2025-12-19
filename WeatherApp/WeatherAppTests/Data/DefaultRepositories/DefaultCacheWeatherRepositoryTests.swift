//
//  DefaultCacheWeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import XCTest
@testable import WeatherApp

@MainActor
final class DefaultCacheWeatherRepositoryTests: XCTestCase {
    private let key = "anyKey"
    var repository: CacheWeatherRepository!
    
    override func setUpWithError() throws {
        repository = DefaultCacheWeatherRepository.shared
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    func testSetCache() {
        // given
        let cacheItem = CacheWeatherItem(timestamp: Date(),
                                     currentWeather: TestHelpers.makeCurrentWeather())
        // when
        repository.setCache(cacheItem, key: key)
        
        // result
        let cache = repository.getCache(key: key)
        XCTAssertEqual(cache?.currentWeather, TestHelpers.makeCurrentWeather())
    }
    
    func testRemoveCache() async throws {
        // given
        let cacheItem = CacheWeatherItem(timestamp: Date(),
                                     currentWeather: TestHelpers.makeCurrentWeather())
        
        repository.setCache(cacheItem, key: key)
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // when
        repository.removeCache(key: key)
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // result
        let cache = repository.getCache(key: key)
        XCTAssertNil(cache)
    }
}
