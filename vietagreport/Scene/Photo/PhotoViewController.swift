//
//  PhotoViewController.swift
//  vietagreport
//  Edit image, Capture camera with vintage effect photo
//
//
//  Created by Hoi Dang Quoc on 5/20/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

protocol PhotoDisplayLogic {
    
}

class PhotoViewController: UIViewController {

    lazy var photoView: PhotoView = { [unowned self] in
        let view = PhotoView()
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    deinit {
        debugPrint("PhotoViewController deinit")
    }
    
    
    override func loadView() {
        view = photoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
