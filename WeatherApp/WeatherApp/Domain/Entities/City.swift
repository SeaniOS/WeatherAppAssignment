//
//  City.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

struct City: Codable, Equatable {
    let name: String
    let country: String
    let latitude: String
    let longitude: String
}

extension City {
    /// some cities share the same name, therefore country should be displayed together
    var displayedName: String {
        if country.isEmpty { return name }
        return "\(name), \(country)"
    }
}
