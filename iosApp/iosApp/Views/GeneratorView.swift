//
//  GeneratorView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 19.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit
import shared

class GeneratorView: UIView {
    var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    var headerHolder: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        view.layer.cornerRadius = 4
        return view
    }()
    
    var contentHolder: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var mainHolder: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()
    
    var favoritesHolder: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    var mainButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 3
        button.backgroundColor = .white
        button.titleLabel?.font = .medium12
        button.setText(text: sharedStrings.main.localized(), kern: 1.2)
        button.tag = GeneratorTab.main.rawValue
        button.shadow(radius: 4, opacity: 0.12)
        return button
    }()
    
    var favoritesButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 3
        button.backgroundColor = .clear
        button.titleLabel?.font = .regular12
        button.setText(text: sharedStrings.favorite.localized(), kern: 1.2)
        button.tag = GeneratorTab.favorite.rawValue
        return button
    }()

    var generateText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.font = .regular12
        view.placeholder = sharedStrings.enter_text.localized()
        view.autocorrectionType = .no

        let paddingView = UIView(frame: CGRectMake(0, 0, 10, view.frame.height))
        view.leftView = paddingView
        view.leftViewMode = UITextField.ViewMode.always
        
        return view
    }()
    
    var generateButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.medium12
        button.layer.cornerRadius = 6
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        button.setText(text: sharedStrings.generate.localized(), kern: 1.2)
        button.backgroundColor = UIColor.link
        return button
    }()

    var generatedImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.allowsEdgeAntialiasing = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .background
        view.layer.cornerRadius = 6
        return view
    }()
    
    var favoriteButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        button.tintColor = .darkGray
        button.layer.cornerRadius = 22
        button.backgroundColor = .white.withAlphaComponent(0.5)
        return button
    }()
    
    var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.bounces = true
        return collectionView
    }()
    
    var favoritesPlaceholderView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    var placeholderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular14
        label.numberOfLines = 0
        label.text = sharedStrings.no_images.localized()
        return label
    }()

    var loadingIndicator: LoadingIndicator = {
        let indicator = LoadingIndicator()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .link
        indicator.lineWidth = 4
        indicator.isUserInteractionEnabled = false
        return indicator
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
        addSubview(loadingIndicator)

        if #available(iOS 11.0, *) {
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: statusBarHeight).isActive = true
        }
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        if #available(iOS 11.0, *) {
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomBarHeight).isActive = true
        }
        
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        containerView.addSubview(headerHolder)
        containerView.addSubview(contentHolder)
        
        headerHolder.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        headerHolder.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        headerHolder.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        headerHolder.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        contentHolder.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        contentHolder.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        contentHolder.topAnchor.constraint(equalTo: headerHolder.bottomAnchor, constant: 10).isActive = true
        contentHolder.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        contentHolder.addSubview(mainHolder)
        contentHolder.addSubview(favoritesHolder)
        
        mainHolder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor).isActive = true
        mainHolder.trailingAnchor.constraint(equalTo: contentHolder.trailingAnchor).isActive = true
        mainHolder.topAnchor.constraint(equalTo: contentHolder.topAnchor, constant: 10).isActive = true
        mainHolder.bottomAnchor.constraint(equalTo: contentHolder.bottomAnchor).isActive = true
        
        favoritesHolder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor).isActive = true
        favoritesHolder.trailingAnchor.constraint(equalTo: contentHolder.trailingAnchor).isActive = true
        favoritesHolder.topAnchor.constraint(equalTo: contentHolder.topAnchor).isActive = true
        favoritesHolder.bottomAnchor.constraint(equalTo: contentHolder.bottomAnchor).isActive = true

        headerHolder.addSubview(mainButton)
        headerHolder.addSubview(favoritesButton)
        
        mainButton.leadingAnchor.constraint(equalTo: headerHolder.leadingAnchor, constant: 2).isActive = true
        mainButton.topAnchor.constraint(equalTo: headerHolder.topAnchor, constant: 2).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: headerHolder.bottomAnchor, constant: -2).isActive = true
        mainButton.widthAnchor.constraint(equalTo: favoritesButton.widthAnchor).isActive = true
        
        favoritesButton.leadingAnchor.constraint(equalTo: mainButton.trailingAnchor, constant: 2).isActive = true
        favoritesButton.topAnchor.constraint(equalTo: headerHolder.topAnchor, constant: 2).isActive = true
        favoritesButton.bottomAnchor.constraint(equalTo: headerHolder.bottomAnchor, constant: -2).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: headerHolder.trailingAnchor, constant: -2).isActive = true
        
        mainHolder.addSubview(generateText)
        mainHolder.addSubview(generateButton)
        mainHolder.addSubview(generatedImage)
        mainHolder.addSubview(favoriteButton)
        
        generateText.topAnchor.constraint(equalTo: mainHolder.topAnchor).isActive = true
        generateText.leadingAnchor.constraint(equalTo: mainHolder.leadingAnchor).isActive = true
        generateText.heightAnchor.constraint(equalTo: generateButton.heightAnchor).isActive = true

        generateButton.topAnchor.constraint(equalTo: mainHolder.topAnchor).isActive = true
        generateButton.leadingAnchor.constraint(equalTo: generateText.trailingAnchor, constant: 10).isActive = true
        generateButton.trailingAnchor.constraint(equalTo: mainHolder.trailingAnchor).isActive = true
        generateButton.widthAnchor.constraint(greaterThanOrEqualTo: generateText.widthAnchor, multiplier: 0.5).isActive = true
        
        favoriteButton.trailingAnchor.constraint(equalTo: mainHolder.trailingAnchor, constant: -10).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: generatedImage.topAnchor, constant: 10).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor).isActive = true
        
        generatedImage.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 20).isActive = true
        generatedImage.leadingAnchor.constraint(equalTo: mainHolder.leadingAnchor).isActive = true
        generatedImage.trailingAnchor.constraint(equalTo: mainHolder.trailingAnchor).isActive = true
        generatedImage.heightAnchor.constraint(equalTo: generatedImage.widthAnchor).isActive = true

        favoritesHolder.addSubview(collectionView)
        favoritesHolder.addSubview(favoritesPlaceholderView)
        
        collectionView.leadingAnchor.constraint(equalTo: favoritesHolder.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: favoritesHolder.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: favoritesHolder.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: favoritesHolder.bottomAnchor).isActive = true
        
        favoritesPlaceholderView.leadingAnchor.constraint(equalTo: favoritesHolder.leadingAnchor).isActive = true
        favoritesPlaceholderView.trailingAnchor.constraint(equalTo: favoritesHolder.trailingAnchor).isActive = true
        favoritesPlaceholderView.topAnchor.constraint(equalTo: favoritesHolder.topAnchor).isActive = true
        favoritesPlaceholderView.bottomAnchor.constraint(equalTo: favoritesHolder.bottomAnchor).isActive = true
        
        favoritesPlaceholderView.addSubview(placeholderLabel)
        
        placeholderLabel.centerXAnchor.constraint(equalTo: favoritesPlaceholderView.centerXAnchor).isActive = true
        placeholderLabel.centerYAnchor.constraint(equalTo: favoritesPlaceholderView.centerYAnchor).isActive = true
        placeholderLabel.widthAnchor.constraint(lessThanOrEqualTo: favoritesPlaceholderView.widthAnchor, multiplier: 0.7).isActive = true
    }
}

enum GeneratorTab: Int {
    case main = 0
    case favorite = 1
}
