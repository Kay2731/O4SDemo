//
//  Cache.swift
//  O4S
//
//  Created by Keertika on 07/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import Foundation
import UIKit
class Cache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!

    static let shared = Cache()

    private init() {
        // make sure to purge cache on memory pressure

    observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }

    deinit {
        if let observer = observer{
        NotificationCenter.default.removeObserver(observer )
        }
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
