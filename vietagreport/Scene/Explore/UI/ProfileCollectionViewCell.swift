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
        return imageView
    }()
    
    lazy var messageLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
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
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[profileImage(100)]-10-[messageLabel]-30-[percentIncreaseLabel]-20-[drinkVolumneLabel]",
                                                                 options: [.alignAllLeading, .alignAllTrailing],
                                                                 metrics: [:],
                                                                 views: viewsDictionary)
        let horizontalConstrants = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[profileImage]-20-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: viewsDictionary)
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstrants)
    }
}
