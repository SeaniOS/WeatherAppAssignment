//
//  DependencyInjectionHandler.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

class DependencyInjectionHandler {
    func makeHomeViewModel() -> DefaultHomeViewModel {
        return DefaultHomeViewModel()
    }
    
    func makeSearchResultsViewModel() -> DefaultSearchResultsViewModel {
        return DefaultSearchResultsViewModel(cityUseCase: makeCityUseCase())
    }
}

extension DependencyInjectionHandler {
    private func makeCityUseCase() -> CityUseCase {
        return DefaultCityUseCase(cityRepository: makeCityRepository())
    }
    
    private func makeCityRepository() -> CityRepository {
        return DefaultCityRepository()
    }
}
