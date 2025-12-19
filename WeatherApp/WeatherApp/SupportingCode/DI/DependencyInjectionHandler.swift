//
//  DependencyInjectionHandler.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

protocol DependencyInjection {
    func makeHomeViewModel() -> HomeViewModel
    func makeSearchResultsViewModel() -> SearchResultsViewModel
    func makeCityViewModel(city: City) -> DefaultCityViewModel
}

// MARK: - View Models
class DependencyInjectionHandler: DependencyInjection {
    func makeHomeViewModel() -> HomeViewModel {
        return DefaultHomeViewModel()
    }
    
    func makeSearchResultsViewModel() -> SearchResultsViewModel {
        return DefaultSearchResultsViewModel(cityUseCase: makeCityUseCase())
    }
    
    func makeCityViewModel(city: City) -> DefaultCityViewModel {
        return DefaultCityViewModel(city: city, weatherUseCase: makeWeatherUseCase())
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

