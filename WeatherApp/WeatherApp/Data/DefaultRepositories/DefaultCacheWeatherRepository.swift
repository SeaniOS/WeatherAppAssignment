//
//  DefaultCacheWeatherRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

final class DefaultCacheWeatherRepository: CacheWeatherRepository {
    private let cache = NSCache<NSString, CacheWeatherItem>()
    private init() {}
    static let shared = DefaultCacheWeatherRepository()
    
    func getCache(key: String) -> CacheWeatherItem? {
        cache.object(forKey: key as NSString)
    }
    
    func setCache(_ item: CacheWeatherItem, key: String) {
        cache.setObject(item, forKey: key as NSString)
    }
    
    func removeCache(key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}


