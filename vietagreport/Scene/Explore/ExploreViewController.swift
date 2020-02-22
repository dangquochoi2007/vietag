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
    
    lazy var exploreView: ExploreView = {
        let view = ExploreView()
        view.exploreCollectionView.delegate = self
        view.exploreCollectionView.dataSource = self
        return view
    }()
    
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
            print("Task 1 done")
        }
        queue.async {
            print("Task 2 done")
        }
        group.wait()
        print("All task done")
    }
    
    private func configureWhenAppear() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanCollectionViewCell", for: indexPath) as! PlanCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 128.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
