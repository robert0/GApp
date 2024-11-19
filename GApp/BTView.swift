//
//  BTView.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI
import CoreBluetooth

struct BTView: View {
    @ObservedObject var viewModel = BTViewModel()
    //@State var $selected: String?
    @State private var selection: String?
    
    // The bluetooth panel
    var body: some View {
        return VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.gray)
            //Text("BT State: \(viewModel.updateCounter)")
            Button("Press to start Bluetooth Streaming", action: startBTAdvertising)
            Button("Press to start Send Message", action: streamAccelerometerData)
            
//            var entries = viewModel.bto?.getPeripheralMap() ?? [:]
//            if !entries.isEmpty {
//                VStack {
//                    Text("Scanning...")
//                    List(selection: $selection) {
//                        ForEach(entries.elements, id: \.key) { key, value in
//                            if(value.name != nil) {//allow only named BTs
//                                Text(value.name!)
//                            }
//                        }
//                        .padding(.bottom)
//                    }
//                    .frame(width: nil, height: 300)
//                    .background(Color.white)
//                    
//                    Button("Connect", action: startBT)
//                        .disabled(selection == nil)
//                }.background(Color.white).padding(20)
//            }
        }
    }
    
    func startBTAdvertising() {
        Globals.logToScreen("startBTAdvertising called..")
        viewModel.bto = BTPeripheralObj()
        //viewModel.bto!.setChangeListener(self)
    }
    
   
    func streamAccelerometerData() {
        Globals.logToScreen("streamAccelerometerData called..")
        if(viewModel.bto != nil){
            SensorMgr.registerListener(viewModel.bto!)
        }
    }
    
}

//
// Helper class for DataView that handles the updates
//
// Created by Robert Talianu
//
final class BTViewModel: ObservableObject {
    @Published var updateCounter: Int = 1
    @Published var bto: BTPeripheralObj?
    @Published var btMgr: CBCentralManager?
    @Published var selection: String?
    
}
