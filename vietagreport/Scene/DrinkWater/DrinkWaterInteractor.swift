//
//  DrinkWaterInteractor.swift
//  vietagreport
//
//  Created by Hoi on 3/1/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import Foundation

protocol DrinkWaterBusinessLogic {
    
}

protocol DrinkWaterDataStore {
    
}

class DrinkWaterInteractor: DrinkWaterBusinessLogic, DrinkWaterDataStore {
    var presenter: DrinkWaterPresentationLogic?
}
