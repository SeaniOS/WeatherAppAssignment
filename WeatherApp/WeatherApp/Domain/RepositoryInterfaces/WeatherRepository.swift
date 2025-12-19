//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

protocol WeatherRepository {
    func fetchCurrentWeather(latitude: String, longitude: String) async throws -> WeatherResponse
}
