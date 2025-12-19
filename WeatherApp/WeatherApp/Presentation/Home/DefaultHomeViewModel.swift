//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation
import Combine

protocol HomeViewModel {
    var cities: [City] { get }
    func fetchCityHistories()
}

final class DefaultHomeViewModel: HomeViewModel {
    var cities: [City] = []
    private let cityHistoryUseCase: CityHistoryUseCase
    
    init(cityHistoryUseCase: CityHistoryUseCase) {
        self.cityHistoryUseCase = cityHistoryUseCase
    }
    
    func fetchCityHistories() {
        cities = cityHistoryUseCase.fetchCityHistories()
    }
}
