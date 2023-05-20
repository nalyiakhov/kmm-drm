//
//  UIImageView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 19.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit
import shared

let imageCache: NSCache<AnyObject, UIImage> = {
    let cache = NSCache<AnyObject, UIImage>()
    cache.countLimit = 10
    cache.totalCostLimit = 100 * 1024 * 1024
    return cache
}()

private var AssociatedObjectHandle: UInt8 = 0

extension UIImageView {
    var url: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    typealias Action = (UIImage?) -> ()

    func load(_ urlString: String?, contentMode: UIView.ContentMode = .scaleAspectFill, completion: @escaping (String?) -> Void) {
        if let urlString = urlString, !urlString.isEmpty {
            self.contentMode = contentMode
            self.url = urlString
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
                self.image = imageFromCache
                completion(nil)
            } else {
                self.image = nil
                guard let url = URL(string: urlString) else {
                    completion(nil)
                    return
                }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async() {
                        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let data = data, error == nil, let image = UIImage(data: data) else {
                            completion(error?.localizedDescription ?? sharedStrings.loading_error.localized())
                            return
                        }
                        if urlString == self.url {
                            self.image = image
                            imageCache.setObject(image, forKey: urlString as AnyObject)
                            completion(nil)
                        }
                    }
                }.resume()
            }
        } else {
            self.url = nil
            self.image = nil
            completion(nil)
        }
    }
}
