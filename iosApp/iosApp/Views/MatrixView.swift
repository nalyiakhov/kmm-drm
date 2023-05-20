//
//  MatrixView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 21.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit
import shared

class MatrixView: UIView {
    var containerView: UIView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var calculateButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(sharedStrings.calculate.localized(), for: .normal)
        button.titleLabel?.font = UIFont.medium16
        button.setTitleColor(UIColor.text, for: .normal)
        return button
    }()

    override init(frame:CGRect) {
        super.init(frame:frame)

        backgroundColor = .white
        
        setupViews()
    }

    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }

    fileprivate func setupViews() {
        addSubview(containerView)

        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        containerView.addSubview(calculateButton)
        
        calculateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        calculateButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        calculateButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}
