//
//  StartVC.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 19.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit

class StartVC: CustomViewController {
    var customView: StartView {
        return view as! StartView
    }

    weak var matrixButton: UIButton! { return customView.matrixButton }
    weak var generatorButton: UIButton! { return customView.generatorButton }
    weak var marketButton: UIButton! { return customView.marketButton }

    override func loadView() {
        self.view = StartView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        matrixButton.addTarget(self, action: #selector(toMatrix), for: .touchUpInside)
        generatorButton.addTarget(self, action: #selector(toGenerator), for: .touchUpInside)
        marketButton.addTarget(self, action: #selector(toMarket), for: .touchUpInside)
    }
    
    @objc fileprivate func toMatrix() {
        let marketVC = MainVC()
        present(marketVC, animated: true)
    }
    
    @objc fileprivate func toGenerator() {
        let generatorVC = GeneratorVC()
        generatorVC.modalPresentationStyle = .fullScreen
        present(generatorVC, animated: true)
    }
    
    @objc fileprivate func toMarket() {
        let marketVC = MainVC()
        present(marketVC, animated: true)
    }
}
