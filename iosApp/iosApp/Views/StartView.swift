//
//  StartView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 19.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit
import shared

class StartView: UIView {
    var containerView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 20
        return stackView
    }()

    var matrixButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(sharedStrings.matrix.localized(), for: .normal)
        button.titleLabel?.font = UIFont.medium16
        button.setTitleColor(UIColor.text, for: .normal)
        return button
    }()
    
    var generatorButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(sharedStrings.generator.localized(), for: .normal)
        button.titleLabel?.font = UIFont.medium16
        button.setTitleColor(UIColor.text, for: .normal)
        return button
    }()
    
    var marketButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(sharedStrings.market.localized(), for: .normal)
        button.titleLabel?.font = UIFont.medium16
        button.setTitleColor(UIColor.text, for: .normal)
        return button
    }()

    override init(frame:CGRect) {
        super.init(frame:frame)

        backgroundColor = .white
        
        containerView.addArrangedSubview(matrixButton)
        containerView.addArrangedSubview(generatorButton)
        containerView.addArrangedSubview(marketButton)
        
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
    }
}
