//
//  DefaultCityRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

final class DefaultCityRepository: CityRepository {
    func searchCities(searchTerm: String) async throws -> SearchCityResponse? {
        guard let url = APIQuery.searchCities(searchTerm).url else {
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
