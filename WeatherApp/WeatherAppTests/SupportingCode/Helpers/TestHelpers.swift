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
    
    private static let imageURL = "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
    private static let weatherDescription = "Partly Cloudy"
    private static let temperature = "21"
    private static let humidity = "83"
    
    static let searchTerm = "hanoi"
    
    static func makeSearchCityResponse() -> SearchCityResponse {
        let name = ValueWrapper(value: name)
        let country = ValueWrapper(value: country)
        
        let city: CityResponse = .init(areaName: [name],
                                       country: [country],
                                       latitude: latitude,
                                       longitude: longitude)
        return .init(searchAPI: .init(cities: [city]))
    }
    
    static func makeSearchCityResponse_MissingAreaName() -> SearchCityResponse {
        let country = ValueWrapper(value: country)
        
        let city: CityResponse = .init(areaName: [],
                                       country: [country],
                                       latitude: latitude,
                                       longitude: longitude)
        return .init(searchAPI: .init(cities: [city]))
    }
    
    static func makeSearchCityResponse_MissingCountry() -> SearchCityResponse {
        let name = ValueWrapper(value: name)
        
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

extension TestHelpers {
    static func makeWeatherResponse() -> WeatherResponse {
        let currentCondition = CurrentCondition(imageURL: [ValueWrapper(value: imageURL)],
                                                description: [ValueWrapper(value: weatherDescription)],
                                                temperature: temperature,
                                                humidity: humidity)
        return .init(data:WeatherData(currentCondition: [currentCondition]))
    }
    
    static func makeCurrentWeather() -> CurrentWeather {
        return .init(imageURL: imageURL, description: weatherDescription, temperature: temperature, humidity: humidity)
    }
    
    static func makeCacheCurrentWeather() -> CurrentWeather {
        return .init(imageURL: imageURL, description: weatherDescription + "Cache", temperature: temperature, humidity: humidity)
    }
}

extension TestHelpers {
    static func makeMockSearchCitiesResponseData() -> Data? {
        let bundle = Bundle(for: WeatherAppTests.self)
        let jsonURL = bundle.url(forResource: "SearchCitiesDummyResponse", withExtension: ".json")!
        
        let mockData = try? Data(contentsOf: jsonURL)
        return mockData
    }
    
    static func makeMockCityWeatherResponseData() -> Data? {
        let bundle = Bundle(for: WeatherAppTests.self)
        let jsonURL = bundle.url(forResource: "CityWeatherDummyResponse", withExtension: ".json")!
        
        let mockData = try? Data(contentsOf: jsonURL)
        return mockData
    }
    
    static func makeMockURLResponse(statusCode: Int) -> HTTPURLResponse? {
        return HTTPURLResponse(url: URL(string: APIConstants.searchURLString)!,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: nil)
    }
}
