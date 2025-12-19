//
//  DefaultCityViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
import Combine
import UIKit

protocol CityViewModel: AnyObject, ObservableObject {
    func onAppear()
    
    var city: City { get }
    var currentWeather: CurrentWeather? { get }
    var uiImage: UIImage? { get }
}

class DefaultCityViewModel: CityViewModel {
    private var weatherUseCase: WeatherUseCase!
    
    @Published var city: City
    @Published var currentWeather: CurrentWeather?
    @Published var uiImage: UIImage?
    
    init(city: City, weatherUseCase: WeatherUseCase) {
        self.city = city
        self.weatherUseCase = weatherUseCase
    }
    
    func onAppear() {
        // let urlString = "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
        Task {
            // fetch current weather
            let currentWeather = await fetchWeather()
            myPrint(currentWeather)
            
            await MainActor.run { [weak self] in
                self?.currentWeather = currentWeather
            }
            
            // load weather icon
            let uiImage = try? await ImageHandler().loadImage(urlString: currentWeather.imageURL)
            
            await MainActor.run { [weak self] in
                self?.uiImage = uiImage
            }
        }
    }
}

extension DefaultCityViewModel {
    private func fetchWeather() async -> CurrentWeather {
        let currentWeather = await weatherUseCase.fetchCurrentWeather(latitude: city.latitude, longitude: city.longitude)
        return currentWeather
    }
}

