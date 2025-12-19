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

class DependencyInjectionHandler: DependencyInjection {
    
}

// MARK: - View Models
extension DependencyInjectionHandler {
    func makeHomeViewModel() -> HomeViewModel {
        return DefaultHomeViewModel(cityHistoryUseCase: makeCityHistoryUseCase())
    }
    
    func makeSearchResultsViewModel() -> SearchResultsViewModel {
        return DefaultSearchResultsViewModel(cityUseCase: makeCityUseCase())
    }
    
    func makeCityViewModel(city: City) -> DefaultCityViewModel {
        return DefaultCityViewModel(city: city,
                                    weatherUseCase: makeWeatherUseCase(),
                                    imageUseCase: makeImageUseCase(),
                                    cityHistoryUseCase: makeCityHistoryUseCase())
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
        return DefaultWeatherUseCase(weatherRepository: makeWeatherRepository(),
                                     cacheRepository: makeCacheWeatherRepository())
    }
    
    private func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository()
    }
    
    private func makeCacheWeatherRepository() -> CacheWeatherRepository {
        return DefaultCacheWeatherRepository.shared
    }
}

// MARK: - Image
extension DependencyInjectionHandler {
    private func makeImageUseCase() -> ImageUseCase {
        return DefaultImageUseCase(cacheImageRepository: makeCacheImageRepository())
    }
    
    private func makeCacheImageRepository() -> CacheImageRepository {
        return DefaultCacheImageRepository.shared
    }
}

// MARK: - City History
extension DependencyInjectionHandler {
    private func makeCityHistoryUseCase() -> CityHistoryUseCase {
        return DefaultCityHistoryUseCase(cityHistoryRepository: makeCityHistoryRepository())
    }
    
    private func makeCityHistoryRepository() -> CityHistoryRepository {
        return DefaultCityHistoryRepository(context: CoreDataStack.shared.context)
    }
}

