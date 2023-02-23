//
//  UIButton.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

extension UIButton {
    func setText(text: String, kern: Double? = nil, lineHeight: CGFloat? = nil) {
        let attributedString = NSMutableAttributedString(string: text)
        if let lineHeight = lineHeight {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = lineHeight
            attributedString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length - 1))
        }
        if let kern = kern {
            attributedString.addAttribute(.kern, value: kern, range: NSRange(location: 0, length: attributedString.length - 1))
        }
        setAttributedTitle(attributedString, for: .normal)
    }
    
    func underlineText() {
        guard let title = title(for: .normal) else { return }
        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(titleString, for: .normal)
    }
}
