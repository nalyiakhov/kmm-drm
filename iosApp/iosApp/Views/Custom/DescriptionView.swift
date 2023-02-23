//
//  DescriptionView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 07.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular16
        label.textColor = .text
        label.numberOfLines = 0
        return label
    }()

    var valueLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular16
        label.textColor = .text
        label.numberOfLines = 0
        return label
    }()

    var separator: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.1
        return view
    }()

    init(name: String, value: String, separatorHidden: Bool = false) {
        super.init(frame:CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        separator.isHidden = separatorHidden
        nameLabel.text = name
        valueLabel.text = value

        setupViews()
    }

    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }

    fileprivate func setupViews() {
        addSubview(nameLabel)
        addSubview(valueLabel)
        addSubview(separator)
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true

        valueLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        separator.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 3).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
