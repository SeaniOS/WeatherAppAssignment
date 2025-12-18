//
//  SearchCityResponse.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

struct SearchCityResponse: Codable, Equatable {
    let searchAPI: SearchAPI
    
    private enum CodingKeys: String, CodingKey {
        case searchAPI = "search_api"
    }
}

struct SearchAPI: Codable, Equatable {
    let cities: [CityResponse]
    
    private enum CodingKeys: String, CodingKey {
        case cities = "result"
    }
}

struct CityResponse: Codable, Equatable {
    let areaName: [Value]
    let country: [Value]
    let latitude: String
    let longitude: String
}

struct Value: Codable, Equatable {
    let value: String
}

// MARK: - Convert
extension SearchCityResponse {
    func toCities() -> [City] {
        self.searchAPI.cities.compactMap { cityResponse in
            let name = cityResponse.areaName.first?.value ?? ""
            guard !name.isEmpty else { return nil }
            
            let country = cityResponse.country.first?.value ?? ""
            
            return City(name: name,
                        country: country,
                        latitude: cityResponse.latitude,
                        longitude: cityResponse.longitude)
        }
    }
}
