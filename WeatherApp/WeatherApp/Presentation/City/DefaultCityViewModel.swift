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
    @Published var city: City
    @Published var uiImage: UIImage?
    
    init(city: City = City(name: "Hanoi", country: "Vietnam", latitude: "21.033", longitude: "105.850")) {
        self.city = city
    }
    
    func onAppear() {
        let urlString = "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
        
        Task {
            let uiImage = await ImageHandler().loadImage(urlString: urlString)
            
            await MainActor.run { [weak self] in
                self?.uiImage = uiImage
            }
        }
    }
}
