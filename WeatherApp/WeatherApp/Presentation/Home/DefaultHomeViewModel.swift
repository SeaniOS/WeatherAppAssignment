//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation
import Combine

protocol HomeViewModel {
    var items: [String] { get }
}

final class DefaultHomeViewModel: HomeViewModel {
    var items: [String] = []
}
