//
 
//  vietagreport
//
//  Created by Hoi on 9/21/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import UIKit
import SwiftUI

protocol LoginDisplayLogic: class {
    
}

class LoginViewController: UIViewController {
    
    lazy var loginView: LoginView = {
        let view = LoginView()
        return view
    }()

    // Custom initializers go here
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Lifecycle
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Layout
    
    // MARK: User Interaction
    
    // MARK: Additional Helpers
}
