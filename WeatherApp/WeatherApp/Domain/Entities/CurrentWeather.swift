//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

struct CurrentWeather: Codable, Equatable {
    let imageURL: String
    let description: String
    let temperature: String
    let humidity: String
    
    static let empty = CurrentWeather(imageURL: "", description: "", temperature: "", humidity: "")
}
