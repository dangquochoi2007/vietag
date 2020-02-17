//
//  ExploreRouter.swift
//  vietagreport
//
//  Created by Hoi on 1/18/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import Foundation

protocol ExploreRoutingLogic {
    func navigateToSchedule()
}

class ExploreRouter: ExploreRoutingLogic {
    weak var viewController: ExploreViewController?
    
    func navigateToSchedule() {
        let scheduleController = ScheduleViewController()
        viewController?.present(scheduleController, animated: true, completion: nil)
    }
}
