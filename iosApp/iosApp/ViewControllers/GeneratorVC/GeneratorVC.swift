//
//  GeneratorVC.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 19.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit
import SQLite3

class GeneratorVC: CustomViewController {
    let cellIdentifier = "favoriteCellIdentifier"
    
    var customView: GeneratorView {
        return view as! GeneratorView
    }

    weak var mainHolder: UIView! { return customView.mainHolder }
    weak var favoritesHolder: UIView! { return customView.favoritesHolder }
    weak var mainButton: UIButton! { return customView.mainButton }
    weak var favoritesButton: UIButton! { return customView.favoritesButton }
    weak var generateText: UITextField! { return customView.generateText }
    weak var generateButton: UIButton! { return customView.generateButton }
    weak var generatedImage: UIImageView! { return customView.generatedImage }
    weak var favoriteButton: UIButton! { return customView.favoriteButton }
    weak var collectionView: UICollectionView! { return customView.collectionView }
    weak var favoritesPlaceholderView: UIView! { return customView.favoritesPlaceholderView }
    weak var loadingIndicator: LoadingIndicator! { return customView.loadingIndicator }
    
    let itemsPerRow: CGFloat = isIpad ? 4 : 2
    let sectionInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    let generatePath = "https://dummyimage.com/500x500&text="
    let favoriteImagesLimit = 10
    var favoriteImages: [FavoriteImage] = []
    var images: [FavoriteImage] = []
    var currentImage: FavoriteImage?

    override func loadView() {
        self.view = GeneratorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let favorites = sharedSettings.favoriteImages
        for favoritePath in favorites {
            self.favoriteImages.append(FavoriteImage(fileName: favoritePath))
        }
        
        setupCollectionView()

        mainButton.addTarget(self, action: #selector(doTab), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(doTab), for: .touchUpInside)
        generateButton.addTarget(self, action: #selector(doGenerate), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(doFavorite), for: .touchUpInside)
        
        generateText.becomeFirstResponder()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @objc fileprivate func doTab(sender: UIButton) {
        let tab = sender.tag

        UIView.performWithoutAnimation {
            setupButton(button: mainButton, isActive: tab == GeneratorTab.main.rawValue)
            setupButton(button: favoritesButton, isActive: tab == GeneratorTab.favorite.rawValue)
        }
        
        mainHolder.isHidden = tab != GeneratorTab.main.rawValue
        favoritesHolder.isHidden = tab != GeneratorTab.favorite.rawValue
        
        if tab == GeneratorTab.favorite.rawValue {
            images = favoriteImages
            generateText.resignFirstResponder()
            collectionView.reloadData()
        } else {
            generateText.becomeFirstResponder()
            updateFavorite()
        }
    }
    
    fileprivate func setupButton(button: UIButton, isActive: Bool = false) {
        if isActive {
            button.backgroundColor = .white
            button.titleLabel?.font = .medium12
            button.shadow(radius: 4, opacity: 0.12)
        } else {
            button.backgroundColor = .clear
            button.titleLabel?.font = .regular12
            button.removeShadow()
        }
        button.layoutIfNeeded()
    }
    
    @objc fileprivate func doGenerate() {
        if let generateString = generateText.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !generateString.isEmpty {
            loadingIndicator.startAnimating()
            
            let path = generatePath + generateString
            generatedImage.load(path, contentMode: UIView.ContentMode.scaleAspectFit) { error in
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.currentImage = FavoriteImage(fileName: generateString, image: self.generatedImage.image)
                    self.updateFavorite()

                    if let errorMessage = error {
                        self.showCustomToast(message: errorMessage)
                    }
                }
            }
        } else {
            showCustomToast(message: sharedStrings.enter_text.localized())
        }
    }
    
    @objc fileprivate func doFavorite() {
        if let currentFavoriteImage = currentImage, let image = currentFavoriteImage.image {
            var favoriteImagesPath = sharedSettings.favoriteImages
            
            if !favoriteImages.contains(where: { $0.fileName == currentFavoriteImage.fileName }) {
                if saveImageToDisk(fileName: currentFavoriteImage.fileName, image: image) && !favoriteImagesPath.contains(currentFavoriteImage.fileName) {
                    favoriteImagesPath.append(currentFavoriteImage.fileName)
                    favoriteImages.append(currentFavoriteImage)
                }
                
                if favoriteImages.count > favoriteImagesLimit {
                    if let firstImageName = favoriteImagesPath.first {
                        removeImageFromDisk(fileName: firstImageName)
                    }
                    favoriteImages.removeFirst()
                    favoriteImagesPath.removeFirst()
                }
            } else {
                if let currentFavoriteImage = favoriteImages.first(where: { $0.fileName == currentFavoriteImage.fileName }) {
                    favoriteImagesPath.removeAll(where: { $0 == currentFavoriteImage.fileName })
                }
                
                favoriteImages.removeAll(where: { $0.fileName == currentFavoriteImage.fileName })
                removeImageFromDisk(fileName: currentFavoriteImage.fileName)
            }
            
            sharedSettings.favoriteImages = favoriteImagesPath
            
            updateFavorite()
        }
    }
    
    fileprivate func updateFavorite() {
        if let fileName = currentImage?.fileName {
            favoriteButton.tintColor = favoriteImages.contains(where: { $0.fileName == fileName }) ? .gold : .darkGray
        } else {
            favoriteButton.tintColor = .darkGray
        }
    }
}
