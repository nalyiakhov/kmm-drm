//
//  ImageCollectionViewCell.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 07.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    var previewView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.allowsEdgeAntialiasing = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.concrete
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

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
        contentView.addSubview(previewView)

        previewView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
