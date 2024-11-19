//
//  ViewController.swift
//  GApp
//
//  Created by Robert Talianu
//
import CoreBluetooth
import OrderedCollections
import UIKit

class BTPeripheralObj: NSObject, CBPeripheralManagerDelegate, SensorListener {

    
        
    // Properties
    var peripheralManager: CBPeripheralManager!
    
    let serviceUUID = CBUUID(string: "0000FFF0-0000-1000-2000-300040005000")
    let characteristicUUID = CBUUID(string: "0000FFF0-0000-1000-2000-300040005001")
    var characteristic: CBMutableCharacteristic?
    var counter: Int = 1
    
    private var mDataChangeListener: BTChangeListener?
    
    override init() {
        super.init()
        Globals.logToScreen("Starting CBCentralManager...")
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    /**
     * @param dataChangeListener
     */
    public func setChangeListener(_ dataChangeListener: BTChangeListener) {
        mDataChangeListener = dataChangeListener
    }
    
    //called when Peripheral Manager State changes
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            Globals.logToScreen("BT Peripheral is ON. Creating service and characteristic...")
            //when CBPeripheralManager is ON, add new service/characteristic that will be used for communication
            let characteristic = CBMutableCharacteristic(type: characteristicUUID, properties: [.notify, .read, .write], value: nil, permissions: [.readable, .writeable])
            let service = CBMutableService(type: serviceUUID, primary: true)
            service.characteristics = [characteristic]
            peripheralManager.add(service)
            self.characteristic = characteristic
            
            Globals.logToScreen("BT Start Advertising...")
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
        } else {
            Globals.logToScreen("BT Peripheral is not available.")
        }
    }
    
    //on demand single response
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        if request.characteristic.uuid == characteristicUUID {
            if let value = "Hello Central".data(using: .utf8) {
                request.value = value
                peripheralManager.respond(to: request, withResult: .success)
            }
        }
    }
    
    //on demand multiple requests -> inbound message & reply
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic.uuid == characteristicUUID {
                if let value = request.value, let message = String(data: value, encoding: .utf8) {
                    Globals.logToScreen("BT Received message: \(message)")
                }
                peripheralManager.respond(to: request, withResult: .success)
            }
        }
    }
    
    //fail to advertise, retrying
    func peripheralManager(_ peripheral: CBPeripheralManager, didFailToStartAdvertising error: Error?) {
        Globals.logToScreen("Failed to start advertising, retrying...")
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
    }
    
    //sending a message, by notifying all centrals listening on specific characteristic
    func sendMessage(_ text: String) {
        guard let peripheralMgr = peripheralManager,
              let characteristic = self.characteristic
        else {
            Globals.logToScreen("BT message not send. PeripheralMgr or Characteristic not initialized")
            return
        }
        
        Globals.logToScreen("BT Sending text: \(text) : \(self.counter)")
        let data = text.data(using: .utf8)!
        peripheralMgr.updateValue(data, for: characteristic, onSubscribedCentrals:nil)
    }
    
    
    func onSensorChanged(_ time: Int64, _ x: Double, _ y: Double, _ z: Double) {
        guard let peripheralMgr = peripheralManager,
              let characteristic = self.characteristic
        else {
            Globals.logToScreen("BT message not send. PeripheralMgr or Characteristic not initialized")
            return
        }
        
        let p4d  = Sample4D(x, y, z, time)
        let jsonDataStr = p4d.toJSON(6)
        let jsonData = jsonDataStr.data(using: .utf8) ?? Data()
        
        self.counter += 1
        Globals.logToScreen("BT Sending position: \(jsonDataStr) : \(self.counter)")
        peripheralMgr.updateValue(jsonData, for: characteristic, onSubscribedCentrals:nil)
    }
}
