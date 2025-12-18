//
//  ImageHandler.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 18/12/25.
//

import Foundation
import Combine
import UIKit

final class ImageHandler {
    func loadImage(urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            return image
        } catch {
            myPrint("loadImage failed with error: \(error.localizedDescription)")
            return nil
        }
    }
}
