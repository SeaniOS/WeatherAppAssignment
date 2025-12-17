//
//  CityUseCase.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

protocol CityUseCase {
    func searchCities(searchTerm: String) async -> [City]
}

final class DefaultCityUseCase: CityUseCase {
    private let cityRepository: CityRepository
    
    init(cityRepository: CityRepository) {
        self.cityRepository = cityRepository
    }
    
    func searchCities(searchTerm: String) async -> [City] {
        do {
            let response = try await cityRepository.searchCities(searchTerm: searchTerm)
            myPrint(response)
            return response.toCities()
        } catch {
            myPrint("searchCities with error: \(error.localizedDescription)")
            return []
        }
    }
}
