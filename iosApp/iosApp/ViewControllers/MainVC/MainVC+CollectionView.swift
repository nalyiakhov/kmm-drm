//
//  MainVC+CollectionView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 31.10.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit
import Nuke

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        if let postCell = cell as? ItemCollectionViewCell {
            for gesture in postCell.cardHolder.gestureRecognizers ?? [UIGestureRecognizer]() {
                if gesture is UITapGestureRecognizer {
                    postCell.cardHolder.removeGestureRecognizer(gesture)
                }
            }

            postCell.tag = indexPath.row
            postCell.previewView.image = nil
            postCell.titleLabel.text = nil

            if posts.count > indexPath.row {
                let i = indexPath.row
                let post = posts[i]
                
                postCell.titleLabel.text = post.title
                if let url = URL(string: post.preview ?? "") {
                    Nuke.loadImage(with: url, into: postCell.previewView)
                }
            }

            postCell.cardHolder.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toPost)))
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - (defaultPadding * 2)
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

    @objc fileprivate func toPost(recognizer: UIGestureRecognizer) {
        if let cell = recognizer.view?.superview?.superview as? ItemCollectionViewCell {
            let index = cell.tag
            let item = posts[index]
            
            let postVC = PostVC(item: item)
            postVC.modalPresentationStyle = .fullScreen
            self.present(postVC, animated: true, completion: nil)
        }
    }
}
