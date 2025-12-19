//
//  CacheWeatherRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

protocol CacheWeatherRepository {
    func getCache(key: String) -> CacheWeatherItem?
    func setCache(_ item: CacheWeatherItem, key: String)
    func removeCache(key: String)
}
