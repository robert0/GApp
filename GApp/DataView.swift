//
//  DataView.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI
import os

struct DataView: View, ViewUpdateListener, DataChangeListener, GestureEvaluationListener {
    @ObservedObject var viewModel = DataViewModel()
    
    /**
     *
     */
    var body: some View {
        //        var s = "Dataview body rendered..." + String(self.qList.count)
        //        globals.logToScreen(s)
        //        globals.logToScreen("demo")
        ZStack {
            Text("This is Dataview Panel!")
            //            Canvas { context, size in
            //                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Drawing Code@*/ /*@END_MENU_TOKEN@*/
            //            }

            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))

                for (i, v) in viewModel.qList.enumerated() {
                    path.addLine(to: CGPoint(x: Double(i), y: 150.0 + 10.0 * v.x))
                }
            }.stroke(Color.blue)

            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))

                for (i, v) in viewModel.qList.enumerated() {
                    path.addLine(to: CGPoint(x: Double(i), y: 300.0 + 10.0 * v.y))
                }
            }.stroke(Color.red)

        }.border(Color.red)

    }

    /**
     *
     */
    public func viewUpdate(_ obj: Any) {
        Globals.logToScreen("DataView viewUpdate...")
        var dobj = obj as! MockListenerHandler
        var qobj: RollingQueue<Sample4D> = dobj.getQueue()
        viewModel.qList = qobj.asList()
    }
        
    /**
     *
     */
    public func setDataProvider(_ dataProvider: RealtimeMultiGestureAnalyser) {
        self.viewModel.dataProvider = dataProvider
    }
    
    
    /**
     *
     */
    public func onDataChange() {
        Globals.logToScreen("DataView onDataChange...")
    }
    
    /**
     *
     */
    public func gestureEvaluationCompleted(_ gw: GestureWindow, _ status: GestureEvaluationStatus) {
        Globals.logToScreen("DataView gestureEvaluationCompleted...")
    }
    
}

//
// Helper class for DataView struct
//
// Created by Robert Talianu
//
final class DataViewModel: ObservableObject {
    @Published var qList: [Sample4D] = []
    @Published var dataProvider: RealtimeMultiGestureAnalyser?
    
}
