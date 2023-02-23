//
//  UIView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

extension UIView {
    func shadow(radius: CGFloat = 2, offset: CGFloat = 2, opacity: CGFloat = 0.3, color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = Float(opacity)
        layer.shadowOffset = CGSize(width: 0 , height: offset)
        layer.shadowRadius = radius
    }
    func removeShadow() {
        layer.shadowOpacity = 0
    }
    func rotate(degrees: CGFloat){
        self.transform = CGAffineTransform(rotationAngle: degrees * CGFloat(Double.pi/180))
    }
    func calculatePreferredHeight(preferredWidth: CGFloat? = nil) -> CGFloat {
        let width = preferredWidth ?? frame.width
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==\(width)@999)]", options: [], metrics: nil, views: ["view": self])
        addConstraints(constraint)
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        removeConstraints(constraint)
        return height
    }
}
