//
//  MockCacheWeatherRepository.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
@testable import WeatherApp

final class MockCacheWeatherRepository: CacheWeatherRepository {
    var cacheWeatherItem: CacheWeatherItem?
    
    init(cacheWeatherItem: CacheWeatherItem? = nil) {
        self.cacheWeatherItem = cacheWeatherItem
    }
    
    func getCache(key: String) -> CacheWeatherItem? {
        return cacheWeatherItem
    }
    
    func setCache(_ item: WeatherApp.CacheWeatherItem, key: String) {
        myPrint("setCache::key")
    }
    
    func removeCache(key: String) {
        myPrint("removeCache::key")
    }
}
