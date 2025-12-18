//
//  DefaultCityViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
import Combine
import UIKit

protocol CityViewModel: ObservableObject {
    func onAppear()
    var uiImage: UIImage? { get }
}

class DefaultCityViewModel: CityViewModel {
    private var weatherUseCase: WeatherUseCase!
    
    @Published var city: City
    @Published var currentWeather: CurrentWeather?
    @Published var uiImage: UIImage?
    
    init(city: City = City(name: "Hanoi", country: "Vietnam", latitude: "21.033", longitude: "105.850"), weatherUseCase: WeatherUseCase) {
        self.city = city
        self.weatherUseCase = weatherUseCase
    }
    
    func onAppear() {
        // let urlString = "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
        Task {
            let currentWeather = await fetchWeather()
            myPrint(currentWeather)
            
            let uiImage = await ImageHandler().loadImage(urlString: currentWeather.imageURL)
            myPrint(currentWeather.imageURL)
            
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
