//
//  DefaultCacheImageRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
import UIKit

final class DefaultCacheImageRepository: CacheImageRepository {
    private let cache = NSCache<NSString, UIImage>()
    private init() {}
    static let shared = DefaultCacheImageRepository()
    
    func getCache(key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setCache(_ item: UIImage, key: String) {
        cache.setObject(item, forKey: key as NSString)
    }
}


