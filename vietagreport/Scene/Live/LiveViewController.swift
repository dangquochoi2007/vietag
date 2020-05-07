//
//  LiveViewController.swift
//  vietagreport
//
//  Created by Hoi on 5/7/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import UIKit
import ConnectSDK
import HaishinKit

class LiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func connectTV() {
        var httpStream = HTTPStream()
        httpStream.attachScreen(ScreenCaptureSession(shared: UIApplication.shared))
        
        httpStream.publish("hello")
        var hkView = HKView(frame: view.bounds)
        hkView.attachStream(httpStream)

        var httpService = HLSService(domain: "", type: "_http._tcp", name: "HaishinKit", port: 8080)
        httpService.startRunning()
        httpService.addHTTPStream(httpStream)

        // add ViewController#view
        view.addSubview(hkView)
    }
}
