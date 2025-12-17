//
//  APIConstants.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

enum APIConstants {
    static let key = "5c5711fc299544bcbbe93236251712"
    static let baseURLString = "https://api.worldweatheronline.com/premium/v1/"
    static let searchURLString = baseURLString + "search.ashx"
    static let localWeatherURLString = baseURLString + "weather.ashx"
}
