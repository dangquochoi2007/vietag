//
//  RegisterInteractor.swift
//  vietagreport
//
//  Created by Hoi on 3/29/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import Foundation

protocol RegisterBusinessLogic {
    
}

protocol RegisterDataStore {
    
}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    var presenter: RegisterPresentationLogic?
}
