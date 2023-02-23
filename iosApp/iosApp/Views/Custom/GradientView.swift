//
//  GradientView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 31.10.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    func setup(_ colors: [CGColor], _ locations: [NSNumber], _ startPoint: CGPoint, _ endPoint: CGPoint) {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let gradientLayer = self.layer as? CAGradientLayer else {
            return
        }
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
    }
}
