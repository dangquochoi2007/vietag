//
//  DrinkCollectionViewCell.swift
//  vietagreport
//
//  Created by Hoi on 3/1/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {
    
    lazy var drinkButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitle("Add Drink", for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        for component in [drinkButton] {
            component.translatesAutoresizingMaskIntoConstraints = false
            addSubview(component)
        }
        let viewsDictionary = [
            "drinkButton": drinkButton
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[drinkButton(52)]-(>=0)-|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: viewsDictionary)
        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[drinkButton]-30-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: viewsDictionary)
        
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
