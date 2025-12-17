//
//  SearchCityResponse.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

struct SearchCityResponse: Codable {
    let searchAPI: SearchAPI
    
    private enum CodingKeys: String, CodingKey {
        case searchAPI = "search_api"
    }
}

struct SearchAPI: Codable {
    let cities: [CityResponse]
    
    private enum CodingKeys: String, CodingKey {
        case cities = "result"
    }
}

struct CityResponse: Codable {
    let areaName: [Value]
    let latitude: String
    let longitude: String
}

struct Value: Codable {
    let value: String
}

extension SearchCityResponse {
    func toCities() -> [City] {
        self.searchAPI.cities.compactMap { cityResponse in
            guard let name = cityResponse.areaName.first?.value else { return nil }
            return City(name: name, latitude: cityResponse.latitude, longitude: cityResponse.longitude)
        }
    }
    
}
