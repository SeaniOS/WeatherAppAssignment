//
//  Optional+Extension.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 20/12/25.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: Wrapped {
        if let self {
            return self
        }
        return ""
    }
}

extension Optional where Wrapped: ExpressibleByArrayLiteral { // ex: [CityHistory]?
    var orEmpty: Wrapped {
        if let self {
            return self
        }
        return []
    }
}
