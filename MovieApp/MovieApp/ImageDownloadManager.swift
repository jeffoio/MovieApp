//
//  ImageDownloadManager.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/14.
//

import Foundation

protocol ImageCancelable {
    func downloadCancel()
}

extension URLSessionDataTask: ImageCancelable {
    func downloadCancel() {
        self.cancel()
    }
}

final class ImageDownloadManager {
    static let shared = ImageDownloadManager()
    
    private let cache = ImageCache()
    
    private init() { }
    
    @discardableResult
    func load(urlString: String, completion: @escaping (Data) -> Void) -> ImageCancelable? {
        guard let url = URL(string: urlString) else { return nil }
        if let cached = self.cache.load(key: url.absoluteString) {
            completion(cached)
            return nil
        }
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data else { return }
            
            self.cache.save(data, key: url.absoluteString)
            completion(data)
        }
        downloadTask.resume()
        return downloadTask
    }
}
