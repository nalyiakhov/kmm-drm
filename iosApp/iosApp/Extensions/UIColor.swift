//
//  UIColor.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    static let text = UIColor(r: 55, g: 55, b: 55, alpha: 1.0)
    static let link = UIColor(r: 33, g: 150, b: 243, alpha: 1.0)
    static let background = UIColor(r: 238, g: 238, b: 238, alpha: 1.0)
    static let alphaBackground = UIColor(r: 55, g: 55, b: 55, alpha: 0.5)
    static let codGray = UIColor(r: 17, g: 17, b: 17, alpha: 1.0)
    static let concrete = UIColor(r: 243, g: 243, b: 243, alpha: 1.0)
    static let gold = UIColor(r: 255, g: 215, b: 0, alpha: 1.0)
}
