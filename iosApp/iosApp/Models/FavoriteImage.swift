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
    var image: UIImage?

    init(fileName: String) {
        self.fileName = fileName
        self.image = loadImageFromDisk(fileName: fileName)
    }
    
    init(fileName: String, image: UIImage?) {
        self.fileName = fileName
        self.image = image
    }
}
