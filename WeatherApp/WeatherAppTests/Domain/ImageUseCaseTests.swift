//
//  ImageUseCaseTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

@MainActor
final class ImageUseCaseTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testLoadImage_Cache() async throws {
        // given
        let cacheImage = UIImage(systemName: "gear")
        let mockRepository = MockCacheImageRepository(cacheItem: cacheImage)
        let useCase = DefaultImageUseCase(cacheImageRepository: mockRepository)
        
        // when
        let loadedImage = try await useCase.loadImage(urlString: "")
        
        // then
        XCTAssertEqual(loadedImage, cacheImage)
    }
}
