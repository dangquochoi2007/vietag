//
//  DrinkWaterNavigationController.swift
//  vietagreport
//
//  Created by Hoi on 1/18/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWhenLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func configureWhenLoad() {
        self.navigationBar.prefersLargeTitles = true
    }

}
