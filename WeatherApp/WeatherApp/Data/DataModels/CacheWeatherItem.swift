//
//  CacheWeatherItem.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

class CacheWeatherItem {
    var timestamp: Date
    var currentWeather: CurrentWeather
    
    init(timestamp: Date, currentWeather: CurrentWeather) {
        self.timestamp = timestamp
        self.currentWeather = currentWeather
    }
}
