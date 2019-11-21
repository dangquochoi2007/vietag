//
//  LoginViewController.swift
//  vietagreport
//
//  Created by Hoi on 9/21/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: class {
    
}

class LoginViewController: UIViewController {
    
    var interactor: LoginBusinessLogic?
    var router: LoginRoutingRouterLogic?
    
    lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        debugPrint("LoginViewController deinit")
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
