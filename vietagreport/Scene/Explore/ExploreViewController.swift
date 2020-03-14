//
//  ExploreViewController.swift
//  vietagreport
//
//  Created by Hoi on 10/5/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import UIKit

protocol ExploreDisplayLogic: class {
    
}

class ExploreViewController: UIViewController, ExploreDisplayLogic, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var interactor: ExploreBusinessLogic?
    var router: ExploreRoutingLogic?
    
    lazy var exploreView: ExploreView = { [unowned self] in
        let view = ExploreView()
        view.exploreCollectionView.delegate = self
        view.exploreCollectionView.dataSource = self
        return view
    }()
    
    private var exploreElements: [ExploreViewModel.ExploreElement] = [.Profile, .Drink, .Plan]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureWhenInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implement")
    }
    
    deinit {
        debugPrint("ExploreViewController deinit")
    }
    
    override func loadView() {
        view = exploreView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWhenLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureWhenInit() {
        let exploreViewController = self
        
        let exploreInteractor = ExploreInteractor()
        let explorePresenter = ExplorePresenter()
        let exploreRouter = ExploreRouter()
        
        exploreInteractor.presenter = explorePresenter
        explorePresenter.viewController = exploreViewController
        exploreRouter.viewController = exploreViewController
        
        exploreViewController.interactor = exploreInteractor
        exploreViewController.router = exploreRouter
    }
    
    private func configureWhenLoad() {
        let queue = DispatchQueue(label: "serial-queue")
        let group = DispatchGroup()
        queue.async {
            print("Task 2 done")
        }
        queue.async {
            print("Task 1 done")
        }
        
        group.wait()
        print("All task done")
    }
    
    private func configureWhenAppear() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return exploreElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let element = self.exploreElements[section]
        switch element {
        case .Profile:
            return 1
        case .Plan:
            return 1
        case .Drink:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = self.exploreElements[indexPath.section]
        switch element {
        case .Profile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
            return cell
        case .Plan:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanCollectionViewCell", for: indexPath) as! PlanCollectionViewCell
            cell.notificationButton.addTarget(self, action: #selector(notificationButtonPressed(_:)), for: .touchUpInside)
            cell.scheduleButton.addTarget(self, action: #selector(scheduleButtonPressed(_:)), for: .touchUpInside)
            cell.settingButton.addTarget(self, action: #selector(settingButtonPressed(_:)), for: .touchUpInside)
            return cell
        case .Drink:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinkCollectionViewCell", for: indexPath) as! DrinkCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let element = self.exploreElements[indexPath.section]
        switch element {
        case .Profile:
            return CGSize(width: collectionView.bounds.width, height: 340.0)
        case .Drink:
            return CGSize(width: collectionView.bounds.width, height: 70.0)
        case .Plan:
            return CGSize(width: collectionView.bounds.width, height: 100.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = self.exploreElements[indexPath.section]
        switch element {
        case .Drink:
            router?.navigateToDrinkWater()
        default:
            break
        }
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton) {
        router?.navigateToSchedule()
    }
    
    @IBAction func scheduleButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        
    }
}
