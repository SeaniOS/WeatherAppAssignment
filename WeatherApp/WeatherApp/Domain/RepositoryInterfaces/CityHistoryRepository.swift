//
//  CityHistoryRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

protocol CityHistoryRepository {
    func addCityHistory(city: City)
    func fetchCityHistories() -> [CityHistory]
    func fetchCity(latitude: String, longitude: String) -> CityHistory?
    func updateTimestamp(cityHistory: CityHistory)
}
