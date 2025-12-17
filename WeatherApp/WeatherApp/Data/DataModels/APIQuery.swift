//
//  APIQuery.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation

enum APIQuery {
    case searchCities(String)
    
    var url: URL? {
        switch self {
        case .searchCities(let searchTerm):
            var components = URLComponents(string: APIConstants.searchURL)
            components?.queryItems = [
                .init(name: "key", value: APIConstants.key),
                .init(name: "query", value: searchTerm),
                .init(name: "format", value: "json"),
                .init(name: "num_of_results", value: "10") /// Premium API: 10...50
            ]
            return components?.url
        }
    }
}
