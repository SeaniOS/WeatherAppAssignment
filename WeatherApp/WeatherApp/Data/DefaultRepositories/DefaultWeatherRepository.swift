//
//  DefaultWeatherRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation

final class DefaultWeatherRepository: WeatherRepository {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchCurrentWeather(latitude: String, longitude: String) async throws -> WeatherResponse {
        let url = APIQuery.cityWeather(latitude: latitude, longitude: longitude).url
        
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
        
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
