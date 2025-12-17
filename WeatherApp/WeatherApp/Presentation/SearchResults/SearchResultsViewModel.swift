//
//  SearchResultsViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation
import Combine

final class SearchResultsViewModel {
    private let cityUseCase: CityUseCase
    @Published private(set) var searchedCities = [City]()
    
    // MARK: - Init
    init(cityUseCase: CityUseCase) {
        self.cityUseCase = cityUseCase
    }
    
    func searchCities(searchTerm: String) {
        Task {
            var cities = [City]()
            
            if !searchTerm.trimmingCharacters(in: .whitespaces).isEmpty {
                cities = await cityUseCase.searchCities(searchTerm: searchTerm)
                myPrint(cities)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.searchedCities = cities
            }
        }
        
        /*
         if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
         items = []
         tableView.reloadData()
         return
         }
         
         let firstItem = "\(searchText)-1"
         let secondItem = "\(searchText)-2"
         let thirdItem = "\(searchText)-3"
         items = [firstItem, secondItem, thirdItem]
         tableView.reloadData()
         */
    }
    
}
