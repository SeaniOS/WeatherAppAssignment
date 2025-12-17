//
//  URLSession+Extension.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
