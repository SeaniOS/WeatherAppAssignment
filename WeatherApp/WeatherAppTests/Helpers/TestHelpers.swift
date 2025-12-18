//
//  TestHelpers.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
@testable import WeatherApp

struct TestHelpers {
    private static let name = "Hanoi"
    private static let country = "Vietnam"
    private static let latitude = "21.033"
    private static let longitude = "105.850"
    
    static func makeSearchCityResponse() -> SearchCityResponse {
        let name = Value(value: name)
        let country = Value(value: country)
        
        let city: CityResponse = .init(areaName: [name],
                                       country: [country],
                                       latitude: latitude,
                                       longitude: longitude)
        return .init(searchAPI: .init(cities: [city]))
    }
    
    static func makeSearchCityResponse_MissingAreaName() -> SearchCityResponse {
        let country = Value(value: country)
        
        let city: CityResponse = .init(areaName: [],
                                       country: [country],
                                       latitude: latitude,
                                       longitude: longitude)
        return .init(searchAPI: .init(cities: [city]))
    }
    
    static func makeSearchCityResponse_MissingCountry() -> SearchCityResponse {
        let name = Value(value: name)
        
        let city: CityResponse = .init(areaName: [name],
                                       country: [],
                                       latitude: latitude,
                                       longitude: longitude)
        return .init(searchAPI: .init(cities: [city]))
    }
    
    static func makeCity(country: String = country) -> City {
        return .init(name: name, country: country, latitude: latitude, longitude: longitude)
    }
}
