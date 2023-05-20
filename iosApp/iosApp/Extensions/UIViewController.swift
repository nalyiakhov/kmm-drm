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
    
    func showCustomToast(message : String, delay: CGFloat = 2.0) {
        let toastView = CustomToastView(text: message)
        self.view.addSubview(toastView)
        
        toastView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        toastView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
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
