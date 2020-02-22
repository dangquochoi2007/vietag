//
//  ExploreView.swift
//  vietagreport
//
//  Created by Hoi on 1/11/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class ExploreView: UIView {
    
    lazy var exploreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PlanCollectionViewCell.self, forCellWithReuseIdentifier: "PlanCollectionViewCell")
        return collectionView
    }()

    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        for subView in [exploreCollectionView] {
            self.addSubview(subView)
        }
        
        for attribute: NSLayoutConstraint.Attribute in [.top, .left, .bottom, .right] {
            addConstraint(NSLayoutConstraint(item: exploreCollectionView, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1, constant: 0))
        }
    }
}

class ExploreCollectionViewLayout: UICollectionViewLayout {
    
    override func prepare() {
        super.prepare()
        setupAttributes()
        updateStickyItemsPositions()
    }
    
    private func setupAttributes() {
        guard let _ = self.collectionView else {
            return
        }
        
    }
    
    private func updateStickyItemsPositions() {
        
    }
}
