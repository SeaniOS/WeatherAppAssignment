//
//  DefaultCityRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

final class DefaultCityRepository: CityRepository {
    func searchCities(searchTerm: String) async throws -> SearchCityResponse? {
        let urlString = "\(APIConstants.searchURL)?key=\(APIConstants.key)&query=\(searchTerm)&format=json&num_of_results=10"
        
        guard let url = URL(string: urlString) else {
            myPrint("Invalid URL")
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        #if DEBUG
        if let jsonString = String(data: data, encoding: .utf8) {
            myPrint(jsonString)
        }
        #endif
        
        return try JSONDecoder().decode(SearchCityResponse.self, from: data)
    }
}

extension DefaultCityRepository {
    /*
    func searchCities(searchTerm: String) {
        let urlString = "\(APIConstants.searchURL)?key=\(APIConstants.key)&query=\(searchTerm)&format=json&num_of_results=10"
        
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
                // myPrint(data)
                // myPrint(response)
                if let jsonString = String(data: data, encoding: .utf8) {
                    myPrint(jsonString)
                }
            }
            .store(in: &cancellables)
    }
    */
}
