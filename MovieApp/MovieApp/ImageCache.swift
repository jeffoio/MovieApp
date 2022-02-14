//
//  ImageCache.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/14.
//

import Foundation

final class ImageCache {
    private var cache = NSCache<NSString, NSData>()
    
    init() {
        self.cache.countLimit = 100
    }
    
    func save(_ data: Data, key: String) {
        self.cache.setObject(NSData(data: data), forKey: NSString(string: key))
    }
    
    func load(key: String) -> Data? {
        guard let data = self.cache.object(forKey: NSString(string: key)) else { return nil }
        return Data(referencing: data)
    }
    
    func removeCache() {
        self.cache.removeAllObjects()
    }
}
