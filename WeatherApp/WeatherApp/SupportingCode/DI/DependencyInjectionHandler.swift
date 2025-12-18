//
//  DependencyInjectionHandler.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

// MARK: - View Models
class DependencyInjectionHandler {
    func makeHomeViewModel() -> HomeViewModel {
        return DefaultHomeViewModel()
    }
    
    func makeSearchResultsViewModel() -> SearchResultsViewModel {
        return DefaultSearchResultsViewModel(cityUseCase: makeCityUseCase())
    }
    
    func makeCityViewModel() -> DefaultCityViewModel {
        return DefaultCityViewModel(weatherUseCase: makeWeatherUseCase())
    }
}

// MARK: - City
extension DependencyInjectionHandler {
    private func makeCityUseCase() -> CityUseCase {
        return DefaultCityUseCase(cityRepository: makeCityRepository())
    }
    
    private func makeCityRepository() -> CityRepository {
        return DefaultCityRepository()
    }
}

// MARK: - Weather
extension DependencyInjectionHandler {
    private func makeWeatherUseCase() -> WeatherUseCase {
        return DefaultWeatherUseCase(weatherRepository: makeWeatherRepository())
    }
    
    private func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository()
    }
}
