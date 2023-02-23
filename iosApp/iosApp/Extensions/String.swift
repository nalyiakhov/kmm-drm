//
//  String.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import Foundation

extension String {
    func getDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: self) ?? Date()
    }
    func isDate() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) != nil
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    func htmlAttributedString() -> NSMutableAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return nil }
        return html
    }
}
