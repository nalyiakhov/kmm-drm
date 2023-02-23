//
//  UIApplication.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

private var firstLaunch : Bool = false

extension UIApplication {
    static func isFirstLaunch() -> Bool {
        let firstLaunchKey = "FirstLaunchKey"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchKey) == nil
        if (isFirstLaunch) {
            firstLaunch = isFirstLaunch
            UserDefaults.standard.set(false, forKey: firstLaunchKey)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch || firstLaunch
    }
}
