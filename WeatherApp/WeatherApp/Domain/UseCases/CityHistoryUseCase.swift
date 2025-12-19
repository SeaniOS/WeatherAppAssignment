//
//  CityHistoryUseCase.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

protocol CityHistoryUseCase {
    func saveCityHistory(city: City)
    func fetchCityHistories() -> [City]
}

final class DefaultCityHistoryUseCase: CityHistoryUseCase {
    private let cityHistoryRepository: CityHistoryRepository
    
    init(cityHistoryRepository: CityHistoryRepository) {
        self.cityHistoryRepository = cityHistoryRepository
    }
    
    func saveCityHistory(city: City) {
        // check to see whether there's data in db
        let cityHistory = cityHistoryRepository.fetchCity(latitude: city.latitude, longitude: city.longitude)
        
        if let cityHistory {
            // update
            cityHistoryRepository.updateTimestamp(cityHistory: cityHistory)
        } else {
            // add
            cityHistoryRepository.addCityHistory(city: city)
        }
    }
    
    func fetchCityHistories() -> [City] {
        cityHistoryRepository.fetchCityHistories()
            .map { cityHistory in
                return City(name: cityHistory.name.orEmpty,
                            country: cityHistory.country.orEmpty,
                            latitude: cityHistory.latitude.orEmpty,
                            longitude: cityHistory.longitude.orEmpty)
            }
    }
}
