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
    private var cancellables: Set<AnyCancellable> = []
    private(set) var receivedSearchTerm: String = ""
    @Published var searchedCities: [City] = []
    
    var searchedCitiesPublisher: AnyPublisher<[City], Never> {
        return $searchedCities.eraseToAnyPublisher()
    }
    
    var searchTermSubject = PassthroughSubject<String?, Never>()
    
    init() {
        searchTermSubject
            .sink { [weak self] searchTerm in
                self?.receivedSearchTerm = searchTerm ?? ""
            }
            .store(in: &cancellables)
    }
}

extension MockSearchResultsViewModel {
    func searchCities(searchTerm: String?) async {
        receivedSearchTerm = searchTerm ?? ""
    }
}
