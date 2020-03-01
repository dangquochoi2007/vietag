//
//  DrinkWaterView.swift
//  vietagreport
//
//  Created by Hoi on 3/1/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class DrinkWaterView: UIView {

    lazy var glassCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 100.0, left: 20.0, bottom: 100.0, right: 20.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        for subView in [glassCollectionView] {
            self.addSubview(subView)
        }
        
        for attribute: NSLayoutConstraint.Attribute in [.top, .left, .bottom, .right] {
            addConstraint(NSLayoutConstraint(item: glassCollectionView, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1, constant: 0))
        }
    }
}
