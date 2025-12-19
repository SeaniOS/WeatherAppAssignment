//
//  CacheImageRepository.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
import UIKit

@objc protocol CacheImageRepository {
    func getCache(key: String) -> UIImage?
    @objc optional func setCache(_ item: UIImage, key: String)
}
