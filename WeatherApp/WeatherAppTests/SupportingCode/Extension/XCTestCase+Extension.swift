//
//  XCTestCase+Extension.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
import XCTest

extension XCTestCase {
    func loadViewController(_ viewController: UIViewController) {
        _ = viewController.view
        RunLoop.main.run(until: Date())
    }
}
