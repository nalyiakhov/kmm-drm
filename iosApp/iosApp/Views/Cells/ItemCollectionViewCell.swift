//
//  ItemCollectionViewCell.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 31.10.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
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
        return view
    }()

    var topGradient: GradientView = {
        var view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setup([UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor, UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6).cgColor], [0.0, 1.0], CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 0))
        view.isUserInteractionEnabled = false
        return view
    }()

    var topHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular14
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
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
        cardHolder.addSubview(topHolder)
        cardHolder.addSubview(titleLabel)

        previewView.topAnchor.constraint(equalTo: cardHolder.topAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: cardHolder.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: cardHolder.trailingAnchor).isActive = true

        topHolder.heightAnchor.constraint(equalToConstant: 36).isActive = true
        topHolder.topAnchor.constraint(equalTo: cardHolder.topAnchor).isActive = true
        topHolder.leadingAnchor.constraint(equalTo: cardHolder.leadingAnchor).isActive = true
        topHolder.trailingAnchor.constraint(equalTo: cardHolder.trailingAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: previewView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: cardHolder.bottomAnchor, constant: -5).isActive = true
    }
}
