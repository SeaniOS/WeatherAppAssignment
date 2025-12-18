//
//  MockSearchResultsViewModel.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
@testable import WeatherApp
internal import Combine

final class MockSearchResultsViewModel: SearchResultsViewModel {
    private(set) var receivedSearchTerm: String = ""
    @Published var searchedCities: [City] = []
    
    var searchedCitiesPublisher: AnyPublisher<[City], Never> {
        return $searchedCities.eraseToAnyPublisher()
    }
    
    func searchCities(searchTerm: String?) async {
        receivedSearchTerm = searchTerm ?? ""
    }
}
