//
//  RegisterRouter.swift
//  vietagreport
//
//  Created by Hoi on 3/29/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import Foundation

protocol RegisterRoutingLogic {
    
}

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}

class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
}
