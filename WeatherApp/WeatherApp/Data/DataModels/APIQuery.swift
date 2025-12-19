//
//  APIQuery.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation

enum APIQuery {
    case searchCities(String, baseURLString: String = APIConstants.searchURLString)
    case cityWeather(latitude: String, longitude: String, baseURLString: String = APIConstants.weatherURLString)
    
    var url: URL {
        switch self {
        case let .searchCities(searchTerm, baseURLString):
            var components = URLComponents(string: baseURLString)
            
            components?.queryItems = [
                .init(name: "key", value: APIConstants.key),
                .init(name: "query", value: searchTerm),
                .init(name: "format", value: "json"),
                .init(name: "num_of_results", value: "10") /// Premium API: 10...50
            ]
            
            return components?.url ?? APIQuery.makeSearchURL()!
            /// force-unwrapped safety has been tested: testMakeSearchURL_ForcedUnwrappedSafety
        case let .cityWeather(latitude, longitude, baseURLString):
            var components = URLComponents(string: baseURLString)
            
            let query = "\(latitude),\(longitude)"
            
            components?.queryItems = [
                .init(name: "key", value: APIConstants.key),
                .init(name: "query", value: query),
                .init(name: "format", value: "json"),
                .init(name: "num_of_days", value: "1")
            ]
            return components?.url ?? APIQuery.makeWeatherURL()!
        }
    }
    
    static func makeSearchURL() -> URL? {
        return URL(string: APIConstants.searchURLString)
    }
    
    static func makeWeatherURL() -> URL? {
        return URL(string: APIConstants.weatherURLString)
    }
}
