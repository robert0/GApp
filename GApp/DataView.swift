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

    struct SignalRenderer: View {
        var dataProvider: RealtimeMultiGestureAnalyser?

        var body: some View {

            let dataKeys = dataProvider?.getKeys()
            if dataKeys != nil && dataKeys!.count > 0 {
                ForEach(dataKeys!, id: \.self) { key in
                    Text("")
                    var samples = dataProvider!.getRecordingData(key)
                    Text("")
                    if samples != nil {
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            //                            ForEach(samples!, id: \.self) { index, sample in
                            //                                path.addLine(to: CGPoint(x: Double(index), y: 150.0 + 10.0 * sample.x))
                            //                            }
                        }
                    }
                }
            }
        }
    }

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

            var dataProvider = viewModel.dataProvider
            if dataProvider != nil {
                //draw pointer
                //drawPointers(g, dataProvider!, dataProvider!.getCapacity());

                //draw signals
                SignalRenderer(dataProvider: viewModel.dataProvider)
            }

        }.border(Color.red)

    }

    /**
     *
     */
    public func viewUpdate(_ obj: Any) {
        Globals.logToScreen("DataView viewUpdate...")
        //        var dobj = obj as! MockListenerHandler
        //        var qobj: RollingQueue<Sample4D> = dobj.getQueue()
        //        viewModel.qList = qobj.asList()
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
