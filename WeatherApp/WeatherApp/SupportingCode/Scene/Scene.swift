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
    private let DIHandler = DependencyInjectionHandler()
}

extension Scene {
    func makeHomeViewController() -> HomeViewController {
        let homeViewModel = DIHandler.makeHomeViewModel()
        let searchController = makeSearchController()
        
        let homeViewController = HomeViewController(viewModel: homeViewModel, searchController: searchController)
        return homeViewController
    }
    
    func makeSearchController() -> UISearchController {
        let viewModel = DIHandler.makeSearchResultsViewModel()
        let searchResultsController = SearchResultsViewController(viewModel: viewModel)
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        return searchController
    }
    
    private func makeCityView() -> CityView<DefaultCityViewModel> {
        let viewModel = DIHandler.makeCityViewModel()
        let view = CityView(viewModel: viewModel)
        return view
    }
    
    func makeCityViewController() -> UIViewController {
        let cityView = makeCityView()
        return UIHostingController(rootView: cityView)
    }
}
