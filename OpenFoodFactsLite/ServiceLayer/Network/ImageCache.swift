//
//  ImageCache.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 03.09.2021.
//

import UIKit

class ImageCache {

    static let shared = ImageCache()

    private let cachedImages = NSCache<NSURL, UIImage>()

    func load(url: NSURL, callback: @escaping ((UIImage) -> Void)) -> URLSessionDataTask? {
        guard let wrapURL = url.absoluteURL else { return nil }

        if let image = cachedImages.object(forKey: url) {
            DispatchQueue.main.async {
                callback(image)
            }
            return nil
        }

        let dataTask = URLSession.shared.dataTask(with: wrapURL) { [weak self] (data, _, _) in
            guard let self = self, let unwrapData = data, let image = UIImage(data: unwrapData) else { return }
            self.cachedImages.setObject(image, forKey: url)
            DispatchQueue.main.async {
                callback(image)
            }
        }

        return dataTask
    }

}
