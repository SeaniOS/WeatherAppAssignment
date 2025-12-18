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
    
    static let searchTerm = "hanoi"
    
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

extension TestHelpers {
    static func makeMockSearchCitiesResponseData() -> Data? {
        let bundle = Bundle(for: WeatherAppTests.self)
        guard let jsonURL = bundle.url(forResource: "SearchCitiesDummyResponse", withExtension: ".json") else {
            fatalError("no json file")
        }
        
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
