//
//  UIViewController.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit

extension UIViewController {
    func enableKeyboardHiding() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func isVisible() -> Bool {
        return self.isViewLoaded && self.view.window != nil
    }
}

class CustomViewController: UIViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
