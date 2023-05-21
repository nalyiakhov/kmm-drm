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
    var containerView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 20
        return stackView
    }()

    var taskLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular14
        label.numberOfLines = 0
        label.text = sharedStrings.matrix_task.localized()
        return label
    }()
    
    var fieldsHolder: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var aTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular14
        label.numberOfLines = 0
        label.text = sharedStrings.a_title.localized()
        return label
    }()
    
    var aTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.font = .regular14
        view.autocorrectionType = .no
        view.keyboardType = .numberPad

        let paddingView = UIView(frame: CGRectMake(0, 0, 10, view.frame.height))
        view.leftView = paddingView
        view.leftViewMode = UITextField.ViewMode.always
        
        return view
    }()
    
    var bTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular14
        label.numberOfLines = 0
        label.text = sharedStrings.b_title.localized()
        return label
    }()
    
    var bTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.font = .regular14
        view.autocorrectionType = .no
        view.keyboardType = .numberPad

        let paddingView = UIView(frame: CGRectMake(0, 0, 10, view.frame.height))
        view.leftView = paddingView
        view.leftViewMode = UITextField.ViewMode.always
        
        return view
    }()
    
    var calculateButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.medium16
        button.layer.cornerRadius = 6
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        button.setText(text: sharedStrings.calculate.localized(), kern: 1.2)
        button.backgroundColor = UIColor.link
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
        
        containerView.addArrangedSubview(taskLabel)
        containerView.addArrangedSubview(fieldsHolder)
        containerView.addArrangedSubview(calculateButton)
        
        fieldsHolder.addSubview(aTitleLabel)
        fieldsHolder.addSubview(aTextField)
        fieldsHolder.addSubview(bTitleLabel)
        fieldsHolder.addSubview(bTextField)
        
        aTitleLabel.leadingAnchor.constraint(equalTo: fieldsHolder.leadingAnchor).isActive = true
        aTitleLabel.topAnchor.constraint(equalTo: fieldsHolder.topAnchor).isActive = true
        
        bTitleLabel.leadingAnchor.constraint(equalTo: fieldsHolder.leadingAnchor).isActive = true
        bTitleLabel.topAnchor.constraint(equalTo: aTitleLabel.bottomAnchor, constant: 15).isActive = true
        
        aTextField.topAnchor.constraint(equalTo: aTitleLabel.topAnchor).isActive = true
        aTextField.leadingAnchor.constraint(equalTo: aTitleLabel.trailingAnchor, constant: 10).isActive = true
        aTextField.trailingAnchor.constraint(equalTo: fieldsHolder.trailingAnchor).isActive = true
        aTextField.widthAnchor.constraint(equalTo: aTitleLabel.widthAnchor, multiplier: 2).isActive = true
        
        bTextField.topAnchor.constraint(equalTo: bTitleLabel.topAnchor).isActive = true
        bTextField.leadingAnchor.constraint(equalTo: bTitleLabel.trailingAnchor, constant: 10).isActive = true
        bTextField.trailingAnchor.constraint(equalTo: fieldsHolder.trailingAnchor).isActive = true
        bTextField.widthAnchor.constraint(equalTo: bTitleLabel.widthAnchor, multiplier: 2).isActive = true
        bTextField.bottomAnchor.constraint(equalTo: fieldsHolder.bottomAnchor).isActive = true
    }
}
