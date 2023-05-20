//
//  FavoriteCollectionViewCell.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    var cardHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.shadow(radius: 4, opacity: 0.06, color: .codGray)
        view.layer.cornerRadius = 4
        return view
    }()

    var previewView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.allowsEdgeAntialiasing = true
        view.contentMode = .scaleAspectFit
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setupViews() {
        contentView.addSubview(cardHolder)

        cardHolder.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardHolder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        cardHolder.addSubview(previewView)
        cardHolder.addSubview(favoriteButton)

        previewView.topAnchor.constraint(equalTo: cardHolder.topAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: cardHolder.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: cardHolder.trailingAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: cardHolder.bottomAnchor).isActive = true

        favoriteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: previewView.topAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -5).isActive = true
    }
}
