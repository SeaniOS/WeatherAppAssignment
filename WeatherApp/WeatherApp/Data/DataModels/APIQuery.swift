//
//  APIQuery.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation

enum APIQuery {
    case searchCities(String, baseURLString: String = APIConstants.searchURLString)
    
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
        }
    }
    
    static func makeSearchURL() -> URL? {
        return URL(string: APIConstants.searchURLString)
    }
}
