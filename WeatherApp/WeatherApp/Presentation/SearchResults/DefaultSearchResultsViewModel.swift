//
//  SearchResultsViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation
import Combine

protocol SearchResultsViewModel {
    var searchedCities: [City] { get }
    var searchedCitiesPublisher: AnyPublisher<[City], Never> { get }
    func searchCities(searchTerm: String?) async
}

final class DefaultSearchResultsViewModel: SearchResultsViewModel {
    private let cityUseCase: CityUseCase
    @Published private(set) var searchedCities = [City]()
    
    var searchedCitiesPublisher: AnyPublisher<[City], Never> {
        return $searchedCities.eraseToAnyPublisher()
    }
    
    // MARK: - Init
    init(cityUseCase: CityUseCase) {
        self.cityUseCase = cityUseCase
    }
    
    func searchCities(searchTerm: String?) async {
        var cities = [City]()
        
        if let searchTerm, !searchTerm.trimmingCharacters(in: .whitespaces).isEmpty {
            cities = await cityUseCase.searchCities(searchTerm: searchTerm)
            myPrint(cities)
        }
        
        await MainActor.run { [weak self] in
            self?.searchedCities = cities
        }
    }
}
