//
//  APIConstants.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

enum APIConstants {
    static let key = "5c5711fc299544bcbbe93236251712"
    static let baseURL = "https://api.worldweatheronline.com/premium/v1/"
    static let searchURL = baseURL + "search.ashx"
    static let localWeatherURL = baseURL + "weather.ashx"
}
