//
//  UILabel.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

extension UILabel {
    /*func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }*/
    
    func setText(text: String, kern: Double? = nil, lineHeight: CGFloat? = nil) {
        if text.count > 0 {
            let attributedString = NSMutableAttributedString(string: text)
            if let lineHeight = lineHeight {
                let style = NSMutableParagraphStyle()
                style.minimumLineHeight = lineHeight
                style.lineBreakMode = .byTruncatingTail
                attributedString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length - 1))
            }
            if let kern = kern {
                attributedString.addAttribute(.kern, value: kern, range: NSRange(location: 0, length: attributedString.length - 1))
            }
            attributedText = attributedString
        } else {
            attributedText = nil
        }
    }
    
    func setMargins(leadingMargin: CGFloat = 15, trailingMargin: CGFloat = -15, alignment: NSTextAlignment = .natural) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = leadingMargin
            paragraphStyle.headIndent = leadingMargin
            paragraphStyle.tailIndent = trailingMargin
            paragraphStyle.alignment = alignment
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
