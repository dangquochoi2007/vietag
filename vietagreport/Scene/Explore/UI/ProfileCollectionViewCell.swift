//
//  ProfileCollectionViewCell.swift
//  vietagreport
//
//  Created by Hoi on 2/23/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    lazy var profileImage: UIImageView = { [unowned self] in
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_username")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var messageLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.text = "Hi Miu Ham,\nRemember Drink water regular"
        return label
    }()
    
    lazy var percentIncreaseLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 40)
        label.text = "100%"
        return label
    }()
    
    lazy var drinkVolumneLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.text = "0.4L of 2L"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        for component in [profileImage, messageLabel, percentIncreaseLabel, drinkVolumneLabel] {
            component.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(component)
        }
        let viewsDictionary = [
            "profileImage" : profileImage,
            "messageLabel" : messageLabel,
            "percentIncreaseLabel": percentIncreaseLabel,
            "drinkVolumneLabel": drinkVolumneLabel
        ]
        var allConstraints: [NSLayoutConstraint] = []
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat:"V:|-[profileImage(100)]-10-[messageLabel]-30-[percentIncreaseLabel]-20-[drinkVolumneLabel]-(>=0)-|",
                                                                 options: [.alignAllCenterX],
                                                                         metrics: nil,
                                                                         views: viewsDictionary)
        allConstraints += verticalConstraints
        
        let profileImageHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[profileImage]-|",
                                                                               options: [],
                                                                               metrics: nil,
                                                                               views: viewsDictionary)
        allConstraints += profileImageHorizontalConstraints
        
        let messageLabelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[messageLabel]-20-|",
                                                                               options: [],
                                                                               metrics: nil,
                                                                               views: viewsDictionary)
        allConstraints += messageLabelHorizontalConstraints
        
        let percentIncreaseLabelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[percentIncreaseLabel]-20-|",
                                                                                       options: [],
                                                                                       metrics: nil,
                                                                                       views: viewsDictionary)
        allConstraints += percentIncreaseLabelHorizontalConstraints
        
        let drinkVolumneLabelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[drinkVolumneLabel]-20-|",
                                                                                    options: [],
                                                                                    metrics: nil,
                                                                                    views: viewsDictionary)
        
        allConstraints += drinkVolumneLabelHorizontalConstraints
        NSLayoutConstraint.activate(allConstraints)
    }
}
