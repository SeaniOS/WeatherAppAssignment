//
//  Scene.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
import UIKit
import SwiftUI

struct Scene {
    private var diHandler: DependencyInjectionHandler!
    
    init(diHandler: DependencyInjectionHandler = DependencyInjectionHandler()) {
        self.diHandler = diHandler
    }
}

extension Scene {
    func makeHomeViewController() -> HomeViewController {
        let homeViewModel = diHandler.makeHomeViewModel()
        let searchController = makeSearchController()
        
        let homeViewController = HomeViewController(viewModel: homeViewModel, searchController: searchController)
        return homeViewController
    }
    
    func makeSearchController() -> UISearchController {
        let viewModel = diHandler.makeSearchResultsViewModel()
        let searchResultsController = SearchResultsViewController(viewModel: viewModel)
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        return searchController
    }
    
    private func makeCityView(city: City) -> CityView<DefaultCityViewModel> {
        let viewModel = diHandler.makeCityViewModel(city: city)
        let view = CityView(viewModel: viewModel)
        return view
    }
    
    func makeCityViewController(city: City) -> UIViewController {
        let cityView = makeCityView(city: city)
        return UIHostingController(rootView: cityView)
    }
}

