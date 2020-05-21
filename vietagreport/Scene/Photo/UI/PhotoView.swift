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
        button.backgroundColor = UIColor.red
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
            capturePhotoButton.heightAnchor.constraint(equalToConstant: 48.0),
            capturePhotoButton.widthAnchor.constraint(equalToConstant: 180.0),
            capturePhotoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            capturePhotoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
