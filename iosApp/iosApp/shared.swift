//
//  shared.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import Foundation
import UIKit
import shared
import Toaster

let isIpad = UIDevice.current.userInterfaceIdiom == .pad
let webClient = WebClient()
let defaultPadding: CGFloat = 5

let sharedStrings = SharedRes.strings()

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

func showToast(text: String, duration: TimeInterval = Delay.long) {
    if text.count == 0 {
        return
    }
    
    if let currentToast = ToastCenter.default.currentToast {
        currentToast.cancel()
    }
    
    let toaster = Toast(text: text, duration: duration)
    toaster.show()
}
