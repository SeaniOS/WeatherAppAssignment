//
//  DefaultCityHistoryRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
import CoreData

final class DefaultCityHistoryRepository: CityHistoryRepository {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - Read
extension DefaultCityHistoryRepository {
    func fetchCityHistories() -> [CityHistory] {
        let request = CityHistory.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "timestamp", ascending: false)
        ]
        request.fetchLimit = AppConstants.cityHistoryLimit
        
        let cityHistories = try? context.fetch(request)
        return cityHistories.orEmpty
    }
    
    func fetchCity(latitude: String, longitude: String) -> CityHistory? {
        let request = CityHistory.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", latitude, longitude)
        
        let cityHistory = try? context.fetch(request).first
        return cityHistory
    }
}

// MARK: - Create
extension DefaultCityHistoryRepository {
    func addCityHistory(city: City) {
        let item = CityHistory(context: context)
        item.id = UUID()
        item.timestamp = Date()
        item.name = city.name
        item.country = city.country
        item.latitude = city.latitude
        item.longitude = city.longitude
        
        try? context.save()
    }
}

extension DefaultCityHistoryRepository {
    func updateTimestamp(cityHistory: CityHistory) {
        cityHistory.timestamp = Date()
        
        try? context.save()
    }
}
