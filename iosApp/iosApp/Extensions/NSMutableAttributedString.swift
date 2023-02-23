//
//  NSMutableAttributedString.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

extension NSMutableAttributedString {
    func uppercased() -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        result.enumerateAttributes(in: NSRange(location: 0, length: length), options: []) {_, range, _ in
            result.replaceCharacters(in: range, with: (string as NSString).substring(with: range).uppercased())
        }
        return result
    }
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString: attributedString)
    }
}
