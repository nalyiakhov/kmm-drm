//
//  shared.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import Foundation
import UIKit
import shared

let isIpad = UIDevice.current.userInterfaceIdiom == .pad
let webClient = WebClient()
let defaultPadding: CGFloat = 5

var statusBarHeight: CGFloat {
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
}

var bottomBarHeight: CGFloat {
    guard let root = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
        return 0
    }
    return root.safeAreaInsets.bottom
}
