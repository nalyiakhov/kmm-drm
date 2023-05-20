//
//  FavoriteImage.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import UIKit

class FavoriteImage {
    var fileName: String!
    var image: UIImage? {
        get {
            if let currentImage = _image {
                return currentImage
            } else {
                _image = loadImageFromDisk(fileName: fileName)
                return _image
            }
        }
        set { _image = newValue }
    }
    private var _image: UIImage? = nil

    init(fileName: String) {
        self.fileName = fileName
    }
    
    init(fileName: String, image: UIImage?) {
        self.fileName = fileName
        self.image = image
    }
}
