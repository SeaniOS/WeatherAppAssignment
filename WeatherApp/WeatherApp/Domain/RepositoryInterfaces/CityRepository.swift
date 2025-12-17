//
//  CityRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

protocol CityRepository {
    func searchCities(searchTerm: String) async throws -> SearchCityResponse?
}
