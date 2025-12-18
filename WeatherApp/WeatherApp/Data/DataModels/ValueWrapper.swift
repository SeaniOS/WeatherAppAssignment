//
//  ValueWrapper.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation

struct ValueWrapper: Codable, Equatable {
    let value: String
}

extension Array where Element == ValueWrapper {
    var firstValue: String {
        self.first?.value ?? ""
    }
}
