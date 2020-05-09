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

class LiveViewController: UIViewController, DevicePickerDelegate, ConnectableDeviceDelegate {

    lazy var liveView: LiveView = {
        let view = LiveView()
        view.backgroundColor = UIColor.white
        view.buttonConnect.addTarget(self, action: #selector(buttonConnectPressed(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var connectDevices: ConnectableDevice = {
        let device = ConnectableDevice()
        return device
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        connectTV()
    }
    
    required init?(coder: NSCoder) {
        fatalError(" init?(coder: NSCoder) not implements")
    }
    
    deinit {
        debugPrint("LiveViewController deinit")
    }
    
    override func loadView() {
        view = liveView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonConnectPressed(_ sender: UIButton) {
        // This step could even happen in your app's delegate
        let discover = DiscoveryManager.shared()
        discover?.devicePicker()?.delegate = self
        discover?.startDiscovery()
        discover?.devicePicker()?.show(self)
    }
    
    func connectTV() {
//        var httpStream = HTTPStream()
//        httpStream.attachScreen(ScreenCaptureSession(shared: UIApplication.shared))
//
//        httpStream.publish("hello")
//        var hkView = HKView(frame: view.bounds)
//        hkView.attachStream(httpStream)
//
//        var httpService = HLSService(domain: "", type: "_http._tcp", name: "HaishinKit", port: 8080)
//        httpService.startRunning()
//        httpService.addHTTPStream(httpStream)
//
//        // add ViewController#view
//        view.addSubview(hkView)
    }
    
    // MARK: DevicePickerDelegate
    func devicePicker(_ picker: DevicePicker!, didCancelWithError error: Error!) {
        
    }
    
    func devicePicker(_ picker: DevicePicker!, didSelect device: ConnectableDevice!) {
        connectDevices.delegate = self
        connectDevices.connect()
    }
    
    // MARK: ConnectableDeviceDelegate
    
    func connectableDeviceReady(_ device: ConnectableDevice!) {
        // display content here
        device.mediaPlayer
    }
    
    func connectableDeviceDisconnected(_ device: ConnectableDevice!, withError error: Error!) {
        
    }
    
    func connectableDevicePairingSuccess(_ device: ConnectableDevice!, service: DeviceService!) {
        
    }
    
    func connectableDevice(_ device: ConnectableDevice!, capabilitiesAdded added: [Any]!, removed: [Any]!) {
        
    }
}
