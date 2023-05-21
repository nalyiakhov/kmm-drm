//
//  LocalizationExtensions.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 30.04.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

//make additional extension methods for access from ios native code
//https://github.com/icerockdev/moko-resources#usage

import shared

extension ResourcesStringResource {
    func localized() -> String {
        return MokoResourcesExtensions.shared.asLocalizedString(self)
    }
    
    func localized(args: [String]) -> String {
        return MokoResourcesExtensions.shared.asLocalizedString(self, args: args)
    }
    
    func localized(replace: String) -> String {
        return MokoResourcesExtensions.shared.asLocalizedString(self).replacingOccurrences(of: "%s", with: replace)
    }
}

extension ResourcesPluralsResource {
    func localizedPlural(_ quantity: Int32) -> String {
        return MokoResourcesExtensions.shared.asLocalizedPlural(self, quantity: quantity)
    }
    
    func localizedPlural(_ quantity: Int32, args: [String]) -> String {
        return MokoResourcesExtensions.shared.asLocalizedPlural(self, quantity: quantity, args: args)
    }
}
