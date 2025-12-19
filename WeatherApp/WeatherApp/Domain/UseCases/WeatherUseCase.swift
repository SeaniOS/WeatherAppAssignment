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
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func fetchCurrentWeather(latitude: String, longitude: String) async -> CurrentWeather {
        do {
            let response = try await weatherRepository.fetchCurrentWeather(latitude: latitude, longitude: longitude)
            return response.toCurrentWeather()
        } catch {
            myPrint("fetchCurrentWeather with error: \(error.localizedDescription)")
            return CurrentWeather.empty
        }
    }
}
