//
//  ContentView.swift
//  GApp
//
//  Created by Robert Talianu on 03.10.2024.
//

import SwiftUI

struct AppRootView: View {
    private var analyser:RealtimeMultiGestureAnalyser?
    private var eventsHandler:AccelerometerEventHandler?

    private var keys:[String]
    private var keysIterator:CircularIterator<String>


    //logger view wg
    private var logView: LogView
    
    init () {
        self.keys = ["A", "B", "C"]
        self.keysIterator = CircularIterator(keys, 1000)
        
        //initilize local vars
         self.logView = LogView()
        Globals.setChangeCallback(self.logView.logCallbackFunction)
        
        //initilize app vars
        //Create & link Gesture Analyser
        analyser = RealtimeMultiGestureAnalyser(keys);
        Globals.logToScreen("gesture analyser created...");

        //Create & link accelerometer events handler
        eventsHandler = AccelerometerEventHandler(analyser!);
        Globals.logToScreen("event handler created...");

        SensorsManager accelerometerMgr = SensorsManager.getSensorsManager(SensorsManager.TYPE_ACCELEROMETER, 25000);
        if (accelerometerMgr != null) {
            Globals.logToScreen("accelerometer manager linked...");
            accelerometerMgr.registerListener(eventsHandler);
            Globals.logToScreen("accelerometer registered & listening...");
        }

        //creating the top buttons
        createButtons(form);
        
        //create view painter
        Multi3DGesturePainter pview = new Multi3DGesturePainter();
        pview.setDataProvider(analyser);
        pview.setStateProvider(eventsHandler);
        analyser.setChangeListener(pview);
        analyser.setEvalListener(pview);
        
        
        Globals.logToScreen("Starting mock generator...");
        MockGenerator.start();
        Globals.logToScreen("Mock generator connected...");
    }
    
    var body: some View {
      
        TabView(
            selection: .constant(1)
        ) {
            let av = AppTabView()
            av.tabItem {
                Text("App")
            }.tag(1)

            logView.tabItem {
                Text("Logs")
            }.tag(2)
           

            let btv = BTView()
            btv.tabItem {
                Text("Bluetooth")
            }.tag(3)
        }

    }



}

//#Preview {
//    AppRootView()
//}
