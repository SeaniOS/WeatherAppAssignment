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
    var currentWeather: CurrentWeather { get }
    var uiImage: UIImage? { get }
}

class DefaultCityViewModel: CityViewModel {
    private var weatherUseCase: WeatherUseCase!
    private var imageUseCase: ImageUseCase!
    
    @Published var city: City
    @Published var currentWeather: CurrentWeather = .empty
    @Published var uiImage: UIImage?
    
    init(city: City, weatherUseCase: WeatherUseCase, imageUseCase: ImageUseCase) {
        self.city = city
        self.weatherUseCase = weatherUseCase
        self.imageUseCase = imageUseCase
    }
    
    func onAppear() {
        Task {
            // fetch current weather
            let currentWeather = await fetchWeather()
            myPrint(currentWeather)
            
            await MainActor.run { [weak self] in
                self?.currentWeather = currentWeather
            }
            
            // load weather icon
            let uiImage = try? await imageUseCase.loadImage(urlString: currentWeather.imageURL)
            
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
