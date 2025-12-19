//
//  ImageUseCase.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import Foundation
import UIKit

protocol ImageUseCase {
    func loadImage(urlString: String) async throws -> UIImage?
}

final class DefaultImageUseCase: ImageUseCase {
    private let cacheImageRepository: CacheImageRepository
    private let imageHandler = ImageHandler()
    
    init(cacheImageRepository: CacheImageRepository) {
        self.cacheImageRepository = cacheImageRepository
    }
    
    func loadImage(urlString: String) async throws -> UIImage? {
        // image from cache
        if let cacheImage = cacheImageRepository.getCache(key: urlString) {
            myPrint("image from cache")
            return cacheImage
        }
        
        // load image from URL
        let image = try await imageHandler.loadImage(urlString: urlString)
        
        if let image {
            // save image to cache
            cacheImageRepository.setCache?(image, key: urlString)
            myPrint("image from URL")
        }

        return image
    }
}
