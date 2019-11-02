//
//  TransferServiceScanner.swift
//  vietagreport
//
//  Created by Hoi on 10/5/19.
//  Copyright © 2019 Hoi. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol TransferServiceScannerDelegate: NSObjectProtocol {
    
}

class TransferServiceScanner: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var discoveredPeripheral: CBPeripheral?
    var data: NSMutableData = NSMutableData()
    
    weak var delegate: TransferServiceScannerDelegate?
    
    init(delegate: TransferServiceScannerDelegate?) {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        self.delegate = delegate
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
}
