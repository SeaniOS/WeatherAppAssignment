//
//  MockURLSession.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
@testable import WeatherApp

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return (data ?? Data(), urlResponse ?? URLResponse())
    }
}
