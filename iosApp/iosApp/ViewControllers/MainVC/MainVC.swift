//
//  MainVC.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 11.09.2022.
//

import UIKit
import shared

class MainVC: CustomViewController {
    let cellIdentifier = "postCellIdentifier"
    
    var mainView: MainView {
        return view as! MainView
    }

    let itemsPerRow: CGFloat = isIpad ? 4 : 2
    let sectionInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)

    weak var containerView: UIView! { return mainView.containerView }
    weak var collectionView: UICollectionView! { return mainView.collectionView }
    weak var backgroundView: UIView! { return mainView.backgroundView }
    weak var placeholderView: UIView! { return mainView.placeholderView }
    weak var loadingIndicator: LoadingIndicator! { return mainView.loadingIndicator }
    
    var posts: [Item] = []
    
    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        Task {
            await loadDataAsync()
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: defaultPadding, bottom: 0, right: defaultPadding)
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    private func loadDataAsync() async {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
        
        do {
            defer {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                }
            }
            
            let items = try await UserData().itemsService.loadItems()
            
            DispatchQueue.main.async {
                if items.count > 0 {
                    self.posts = items
                    self.collectionView.reloadData()
                } else {
                    self.placeholderView.isHidden = false
                }
            }
        } catch {
            self.placeholderView.isHidden = false
            
            showToast(text: sharedStrings.loading_error.localized())
        }
    }
}
