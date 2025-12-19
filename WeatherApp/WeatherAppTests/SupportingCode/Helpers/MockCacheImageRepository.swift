//
//  MockCacheImageRepository.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
@testable import WeatherApp
import UIKit

final class MockCacheImageRepository: CacheImageRepository {
    var cacheItem: UIImage?
    
    init(cacheItem: UIImage?) {
        self.cacheItem = cacheItem
    }
    
    func getCache(key: String) -> UIImage? {
        return cacheItem
    }
}
