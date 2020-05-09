//
//  LiveView.swift
//  vietagreport
//
//  Created by Hoi on 5/9/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class LiveView: UIView {
    lazy var buttonConnect: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("Connect TV", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        for subView in [buttonConnect] {
            subView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subView)
        }
        NSLayoutConstraint.activate([
            buttonConnect.widthAnchor.constraint(equalToConstant: 150),
            buttonConnect.heightAnchor.constraint(equalToConstant: 48),
            buttonConnect.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonConnect.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    
}
