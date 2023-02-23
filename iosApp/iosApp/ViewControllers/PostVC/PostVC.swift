//
//  PostVC.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 07.11.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit
import shared

class PostVC: UIViewController {
    let cellIdentifier = "imageCellIdentifier"

    var postView: PostView {
        return view as! PostView
    }

    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        return layout
    }()

    weak var containerView: UIView! { return postView.containerView }
    weak var collectionView: UICollectionView! { return postView.collectionView }
    weak var closeButton: UIButton! { return postView.closeButton }
    weak var titleLabel: UILabel! { return postView.titleLabel }
    weak var descriptionLabel: UILabel! { return postView.descriptionLabel }
    weak var descriptionsHolder: UIStackView! { return postView.descriptionsHolder }
    weak var buyButton: UIButton! { return postView.buyButton }
    weak var pager: UIPageControl! { return postView.pager }

    var post: Item!

    init(item: Item) {
        super.init(nibName: nil, bundle: nil)

        self.post = item
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadView() {
        self.view = PostView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupViews()
        
        closeButton.addTarget(self, action: #selector(doClose), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(doBuy), for: .touchUpInside)
    }

    fileprivate func setupCollectionView() {
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    fileprivate func setupViews() {
        titleLabel.text = post.title
        descriptionLabel.text = post.descr ?? ""
        buyButton.setTitle(post.priceString, for: .normal)

        let descriptions = post.getDescriptions()
        for (name,value) in descriptions {
            let descriptionView = DescriptionView(name: name, value: value)
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
            descriptionsHolder.addArrangedSubview(descriptionView)
        }
    }

    @objc fileprivate func doClose() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc fileprivate func doBuy() {
        print(#function, post.id)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pager.currentPage = Int((collectionView.contentOffset.x / collectionView.frame.width).rounded(.toNearestOrAwayFromZero))
    }
}
