//
//  ViewController.swift
//  GApp
//
//  Created by Robert Talianu
//
import CoreBluetooth
import UIKit
import OrderedCollections

class BTObject: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    // Properties
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var peripheralsMap = OrderedDictionary<String, CBPeripheral>()
    private var mDataChangeListener: BTChangeListener?
    
    override init() {
        super.init()
        Globals.logToScreen("Starting CBCentralManager...")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    /**
     * @param dataChangeListener
     */
    public func setChangeListener(_ dataChangeListener: BTChangeListener) {
        mDataChangeListener = dataChangeListener
    }
    
    /**
     *
     */
    func getPeripheralMap() -> OrderedDictionary<String, CBPeripheral> {
        return peripheralsMap
    }
    
    
    // Called when BT changes state
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        Globals.logToScreen("Central state update:" + String(central.state.rawValue))
        
        mDataChangeListener?.onManagerDataChange(central)
        
        
//        switch central.state {
//        case CBManagerState.poweredOn:
//            // Notify user Bluetooth in ON
//            //startScan()
//            fallthrough
//        case CBManagerState.poweredOff:
//            // Alert user to turn on Bluetooth
//            fallthrough
//        case CBManagerState.resetting:
//            // Wait for next state update and consider logging interruption of Bluetooth service
//            fallthrough
//        case CBManagerState.unauthorized:
//            // Alert user to enable Bluetooth permission in app Settings
//            fallthrough
//        case CBManagerState.unsupported:
//            // Alert user their device does not support Bluetooth and app will not work as expected
//            fallthrough
//        case CBManagerState.unknown:
//            // Wait for next state update
//            fallthrough
//        default:
//            return
//            //Globals.logToScreen("Central state update:" + String(central.state.rawValue))
//        }
    }

    // Start Scanning
    func startScan() {
        Globals.logToScreen("Start Scanning x...")
        peripheralsMap.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    // If we're powered on, start scanning
    //    func centralManagerDidUpdateState(_ central: CBCentralManager) {
    //        Globals.logToScreen("Central state update:" + String(central.state.rawValue))
    //        if central.state != CBManagerState.poweredOn {
    //            Globals.logToScreen("Central is not powered on")
    //        } else {
    //            Globals.logToScreen("Central scanning for " + ParticlePe.blueLEDCharacteristicUUID.uuidString)
    //            centralManager.scanForPeripherals(
    //                withServices: nil,  //[ParticlePe.particleLEDServiceUUID],
    //                options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    //        }
    //    }

    // Handles the result of the scan
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        Globals.logToScreen("Scan update ...")
        Globals.logToScreen("Found peripheral: " + (peripheral.name ?? "no-name, ") + peripheral.identifier.uuidString)
        
        //add peripheral to the map
        peripheralsMap[peripheral.identifier.uuidString] = peripheral
        
        mDataChangeListener?.onPeripheralChange(central, peripheral)
        
        // We've found it so stop scan
        //self.centralManager.stopScan()

        // Copy the peripheral instance
        //self.peripheral = peripheral
        //self.peripheral.delegate = self
      

        // Connect!
        // self.centralManager.connect(self.peripheral, options: nil)

    }

    // The handler if we do connect succesfully
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Globals.logToScreen("peripheral connected ...")
        if peripheral == self.peripheral {
            Globals.logToScreen("Connected to your Particle Board")
            peripheral.discoverServices([ParticlePe.particleLEDServiceUUID])
        }
    }

    // Handles services discovery event
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        Globals.logToScreen("peripheral services discovery completed...")
        if let services = peripheral.services {
            for service in services {
                if service.uuid == ParticlePe.particleLEDServiceUUID {
                    Globals.logToScreen("LED service found")
                    //Now kick off discovery of characteristics
                    peripheral.discoverCharacteristics(
                        [
                            ParticlePe.redLEDCharacteristicUUID,
                            ParticlePe.greenLEDCharacteristicUUID,
                            ParticlePe.blueLEDCharacteristicUUID,
                        ], for: service)
                    return
                }
            }
        }
    }

    // Handling discovery of characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        Globals.logToScreen("peripheral discovery charat...")
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                Globals.logToScreen("Peripheral characteristic found: " + characteristic.description)
                if characteristic.uuid == ParticlePe.redLEDCharacteristicUUID {
                    Globals.logToScreen("Red LED characteristic found")
                } else if characteristic.uuid == ParticlePe.greenLEDCharacteristicUUID {
                    Globals.logToScreen("Green LED characteristic found")
                } else if characteristic.uuid == ParticlePe.blueLEDCharacteristicUUID {
                    Globals.logToScreen("Blue LED characteristic found")
                }
            }
        }
    }
}
