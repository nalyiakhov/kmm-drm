//
//  GeneratorVC+CollectionView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit

extension GeneratorVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritesPlaceholderView.isHidden = images.count > 0
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        if let favoriteCell = cell as? FavoriteCollectionViewCell {
            favoriteCell.previewView.image = nil
            favoriteCell.favoriteButton.tintColor = .darkGray

            if images.count > indexPath.row {
                let i = indexPath.row
                let currentImage = images[i]
                
                favoriteCell.previewView.image = currentImage.image
                favoriteCell.favoriteButton.tintColor = favoriteImages.contains(where: { $0.fileName == currentImage.fileName }) ? .gold : .darkGray
            }

            favoriteCell.favoriteButton.tag = indexPath.row
            favoriteCell.favoriteButton.removeTarget(self, action: #selector(doItemFavorite), for: .touchUpInside)
            favoriteCell.favoriteButton.addTarget(self, action: #selector(doItemFavorite), for: .touchUpInside)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - 20
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    @objc fileprivate func doItemFavorite(sender: UIButton) {
        let index = sender.tag
        let currentImage = images[index]
        var favoriteImagesPath = sharedSettings.favoriteImages
        
        if favoriteImages.contains(where: { $0.fileName == currentImage.fileName }) {
            sender.tintColor = .darkGray
            favoriteImages.removeAll(where: { $0.fileName == currentImage.fileName })
            favoriteImagesPath.removeAll(where: { $0 == currentImage.fileName })
        } else {
            sender.tintColor = .gold
            favoriteImages.append(currentImage)
            favoriteImagesPath.append(currentImage.fileName)
        }
        
        sharedSettings.favoriteImages = favoriteImagesPath
    }
}
