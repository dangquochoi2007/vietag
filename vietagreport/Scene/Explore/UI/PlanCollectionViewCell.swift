//
//  PlanCollectionViewCell.swift
//  vietagreport
//
//  Created by Hoi on 2/9/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class PlanCollectionViewCell: UICollectionViewCell {
    
    lazy var notificationButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle("Notification", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var scheduleButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle("Schedule", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var settingButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        for button in [notificationButton, scheduleButton, settingButton] {
            addSubview(button)
        }
        let viewsDictionary = [
            "notificationButton": notificationButton,
            "scheduleButton": scheduleButton,
            "settingButton": settingButton,
        ]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[notificationButton]",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: viewsDictionary)
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[notificationButton]-[scheduleButton(==notificationButton)]-[settingButton(==notificationButton)]-20-|",
                                                                  options: [.alignAllFirstBaseline],
                                                                  metrics: nil,
                                                                  views: viewsDictionary)
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraint)
    }
}
