//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Paulo Correa on 29/12/2021.
//

import Core

public final class ImageDownloader {
    public static let shared = ImageDownloader()

    private let cache: ImageCacheProtocol

    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: ImageCacheProtocol = ImageCache()) {
        self.cache = cache
    }

    public func loadImage(from url: URL) -> RelayBinder<UIImage?> {
        let imageLoader = RelayBinder<UIImage?>.init(nil)

        if let image = cache[url] {
            imageLoader.value = image
            return imageLoader
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let image = UIImage(data: data ?? Data()) {
                imageLoader.value = image
                self.cache[url] = image
            }
        }.resume()

        return imageLoader
    }
}
