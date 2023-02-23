//
//  PostVC+CollectionView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 07.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit
import Nuke

extension PostVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pager.numberOfPages = isIpad ? post.previewImages.count / 2 : post.previewImages.count
        pager.isHidden = pager.numberOfPages == 1
        return post.previewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        if let postCell = cell as? ImageCollectionViewCell {
            postCell.tag = indexPath.row
            postCell.previewView.image = nil

            if post.previewImages.count > indexPath.row {
                let i = indexPath.row
                let imagePath = post.previewImages[i]

                if let url = URL(string: imagePath) {
                    Nuke.loadImage(with: url, into: postCell.previewView)
                }
            }
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = isIpad ? view.frame.width / 2 : view.frame.width
        return CGSize(width: width, height: width / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
