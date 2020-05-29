//
//  ModalView.swift
//  vietagreport
//
//  Created by Hoi Dang Quoc on 5/29/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class ModalView: UIView {
    
    lazy var imageView: UIImageView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "", size: 24)
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "", size: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setupConstraints() {
        
    }
    
}
