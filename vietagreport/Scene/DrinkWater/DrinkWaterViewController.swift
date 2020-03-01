//
//  DrinkWaterViewController.swift
//  vietagreport
//
//  Created by Hoi on 3/1/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

protocol DrinkWaterDisplayLogic: class {
    
}

class DrinkWaterViewController: UIViewController, DrinkWaterDisplayLogic, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var interactor: DrinkWaterBusinessLogic?
    var router: (NSObjectProtocol & DrinkWaterRoutingLogic & DrinkWaterDataPassing)?
    
    lazy var drinkWaterView: DrinkWaterView = { [unowned self] in
        let view = DrinkWaterView()
        view.glassCollectionView.delegate = self
        view.glassCollectionView.dataSource = self
        return view
    }()
    
    override func loadView() {
        view = drinkWaterView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureWhenInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: ) has not implement yet")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func configureWhenInit() {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        let drinkWaterViewController = self
        
        let drinkWaterInteractor = DrinkWaterInteractor()
        let drinkWaterPresenter = DrinkWaterPresenter()
        let drinkWaterRouter = DrinkWaterRouter()
        
        drinkWaterInteractor.presenter = drinkWaterPresenter
        drinkWaterPresenter.viewController = drinkWaterViewController
        drinkWaterRouter.viewController = drinkWaterViewController
        drinkWaterRouter.dataStore = drinkWaterInteractor
        
        drinkWaterViewController.interactor = drinkWaterInteractor
        drinkWaterViewController.router = drinkWaterRouter
    }
    

    // MARK: -UICollectionViewDataSource, -UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}
