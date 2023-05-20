//
//  CustomToastView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit

class CustomToastView: UIView {
    var toastLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular12
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    init(text: String) {
        super.init(frame:CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        toastLabel.text = text

        setupViews()
    }

    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }

    fileprivate func setupViews() {
        addSubview(toastLabel)
        
        toastLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        toastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        toastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        toastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
