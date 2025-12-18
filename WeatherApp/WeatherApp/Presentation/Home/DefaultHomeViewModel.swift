//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation
import Combine

protocol HomeViewModel {
    var items: [String] { get }
}

final class DefaultHomeViewModel: HomeViewModel {
    var items: [String] = []
}

// MARK: - Demo Weather API
extension DefaultHomeViewModel {
    /*
    func fetchCurrentWeather() {
        let urlString = "\(APIConstants.localWeatherURLString)?key=\(APIConstants.key)&query=21.033,105.850&format=json&num_of_days=1"
        
        guard let url = URL(string: urlString) else {
            myPrint("Invalid URL")
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .sink { completion in
                if case .failure(let err) = completion {
                    myPrint("Retrieving data failed with error \(err)")
                }
            } receiveValue: { data, response in
                if let jsonString = String(data: data, encoding: .utf8) {
                    myPrint(jsonString)
                }
            }
            .store(in: &cancellables)
    }
    */
}
