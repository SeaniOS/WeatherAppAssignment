//
//  APIQueryTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

final class APIQueryTests: XCTestCase {
    
    private let searchTerm = TestHelpers.searchTerm
    
    func testMakeSearchURL_ForcedUnwrappedSafety() {
        let url = APIQuery.makeSearchURL()
        XCTAssertNotNil(url)
    }
    
    func testCaseSearchCities_url() {
        let url = APIQuery.searchCities(searchTerm).url
        
        let expectedURLString = "\(APIConstants.searchURLString)?key=\(APIConstants.key)&query=\(searchTerm)&format=json&num_of_results=10"
        
        XCTAssertEqual(url.absoluteString, expectedURLString)
    }
    
    func testCaseSearchCities_url_invalidBaseURL() {
        let invalidBaseURLString = "https://www.google.com " // have ended spacing
        
        let urlString = APIQuery.searchCities(searchTerm, baseURLString: invalidBaseURLString).url
        
        let expectedURLString = APIConstants.searchURLString
        
        XCTAssertEqual(urlString.absoluteString, expectedURLString)
    }
}
