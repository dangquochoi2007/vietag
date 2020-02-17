//
//  ScheduleViewController.swift
//  vietagreport
//
//  Created by Hoi on 1/18/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

protocol ScheduleDisplayLogic {
    
}

class ScheduleViewController: UIViewController, ScheduleDisplayLogic {
    var interactor: ScheduleBusinessLogic?
    var router: ScheduleRoutingLogic?
    
    lazy var scheduleView: ScheduleView = {
        let view = ScheduleView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureWhenInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implement")
    }
    
    private func configureWhenInit() {
        modalPresentationStyle = .custom
        let scheduleViewController = self
        
        let scheduleInteractor = ScheduleInteractor()
        let schedulePresenter = SchedulePresenter()
        let scheduleRouter = ScheduleRouter()
        
        scheduleInteractor.presenter = schedulePresenter
        schedulePresenter.viewController = scheduleViewController
        scheduleRouter.viewController = scheduleViewController
        
        scheduleViewController.interactor = scheduleInteractor
        scheduleViewController.router = scheduleRouter
    }

    override func loadView() {
        view = scheduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -UIViewControllerTransitioningDelegate
    
}
