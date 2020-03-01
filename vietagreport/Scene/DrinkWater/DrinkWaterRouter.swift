//
//  DrinkWaterRouter.swift
//  vietagreport
//
//  Created by Hoi on 3/1/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import Foundation

protocol DrinkWaterRoutingLogic {
    
}

protocol DrinkWaterDataPassing {
    var dataStore: DrinkWaterDataStore? { get }
}

class DrinkWaterRouter: NSObject, DrinkWaterRoutingLogic, DrinkWaterDataPassing {
    
    weak var viewController: DrinkWaterViewController?
    var dataStore: DrinkWaterDataStore?
    
    
}
