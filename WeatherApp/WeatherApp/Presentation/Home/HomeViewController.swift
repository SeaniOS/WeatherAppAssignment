//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit

class HomeViewController: UIViewController {
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPrint("HomeViewController::viewDidLoad")
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        demoWeatherAPI()
    }
    
    private func demoWeatherAPI() {
        // viewModel.fetchCities()
        viewModel.fetchCurrentWeather()
    }
}
