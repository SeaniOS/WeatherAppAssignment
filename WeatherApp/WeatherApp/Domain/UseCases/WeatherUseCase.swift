//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

protocol WeatherUseCase {
    func fetchCurrentWeather(latitude: String, longitude: String) async -> CurrentWeather
}

final class DefaultWeatherUseCase: WeatherUseCase {
    private let weatherRepository: WeatherRepository
    private let cacheRepository: CacheWeatherRepository
    
    init(weatherRepository: WeatherRepository, cacheRepository: CacheWeatherRepository) {
        self.weatherRepository = weatherRepository
        self.cacheRepository = cacheRepository
    }
    
    func fetchCurrentWeather(latitude: String, longitude: String) async -> CurrentWeather {
        let cacheKey = latitude + "," + longitude
        
        // retrieve from cache first
        if let cachedCurrentWeather = retrieveCache(key: cacheKey) {
            return cachedCurrentWeather
        }
        
        // fetch from API
        do {
            let response = try await weatherRepository.fetchCurrentWeather(latitude: latitude, longitude: longitude)
            let currentWeather = response.toCurrentWeather()

            // save to cache
            saveCache(key: cacheKey, currentWeather: currentWeather)
            return currentWeather
        } catch {
            myPrint("fetchCurrentWeather with error: \(error.localizedDescription)")
            return CurrentWeather.empty
        }
    }
}

// MAKR: - Cache
extension DefaultWeatherUseCase {
    func retrieveCache(key: String) -> CurrentWeather? {
        guard let cacheItem = cacheRepository.getCache(key: key) else {
            return nil
        }
        
        // check timestamp
        if abs(cacheItem.timestamp.timeIntervalSinceNow) > AppConstants.cacheExpiry {
            // remove expired cache item
            cacheRepository.removeCache(key: key)
            return nil
        } else {
            // valid cache
            return cacheItem.currentWeather
        }
    }
    
    func saveCache(key: String, currentWeather: CurrentWeather) {
        if currentWeather != .empty {
            let cacheItem = CacheWeatherItem(timestamp: Date(), currentWeather: currentWeather)
            cacheRepository.setCache(cacheItem, key: key)
        }
    }
}
