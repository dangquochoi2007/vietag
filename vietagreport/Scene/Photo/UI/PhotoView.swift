//
//  PhotoView.swift
//  vietagreport
//
//  Created by Hoi Dang Quoc on 5/20/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    lazy var capturePhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Take Photo", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func setupConstraints() {
        for subView in [capturePhotoButton] {
            addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            capturePhotoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            capturePhotoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            
        ])
    }
}
