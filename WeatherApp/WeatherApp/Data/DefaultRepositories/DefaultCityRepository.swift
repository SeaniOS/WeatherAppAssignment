//
//  DefaultCityRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation

final class DefaultCityRepository: CityRepository {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func searchCities(searchTerm: String) async throws -> SearchCityResponse {
        let url = APIQuery.searchCities(searchTerm).url
        
        let (data, response) = try await session.data(from: url)
        
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
