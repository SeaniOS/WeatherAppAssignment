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
    
    var searchTermSubject: PassthroughSubject<String?, Never> { get }
}

final class DefaultSearchResultsViewModel: SearchResultsViewModel {
    private var cancellables: Set<AnyCancellable> = []
    private var searchTask: Task<Void, Never>?
    private let cityUseCase: CityUseCase
    
    @Published private(set) var searchedCities = [City]()
    var searchedCitiesPublisher: AnyPublisher<[City], Never> {
        return $searchedCities.eraseToAnyPublisher()
    }
    
    let searchTermSubject = PassthroughSubject<String?, Never>()
    
    // MARK: - Init
    init(cityUseCase: CityUseCase) {
        self.cityUseCase = cityUseCase
        binding()
    }
}

extension DefaultSearchResultsViewModel {
    private func binding() {
        searchTermSubject
            .debounce(for: .milliseconds(AppConstants.debounceTime), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                guard let self else { return }
                
                self.searchTask?.cancel()
                
                self.searchTask = Task {
                    await self.searchCities(searchTerm: searchTerm)
                }
            }
            .store(in: &cancellables)
    }
}

extension DefaultSearchResultsViewModel {
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
