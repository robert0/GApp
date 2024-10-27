//
//  DataView.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI
import os

struct DataView: View, DataChangeListener, GestureEvaluationListener {
    @ObservedObject var viewModel = DataViewModel()

    //  RecordedSignal
    //  GApp
    //
    //  Created by Robert Talianu
    //
    struct RecordedSignal: View {
        @ObservedObject var viewModel: DataViewModel

        init(_ viewModel: DataViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            Text("Update rederer: \(viewModel.updateCounter)")
            Text("Recorded data:")
            let dataKeys = viewModel.dataProvider?.getKeys()
            if dataKeys != nil && dataKeys!.count > 0 {
                VStack {
                    ForEach(0..<dataKeys!.count) { index in
                        let key = dataKeys![index]
                        let samples = viewModel.dataProvider!.getRecordingData(key)
                        if samples != nil {
                            ZStack {
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    for (i, v) in samples!.enumerated() {
                                        path.addLine(to: CGPoint(x: Double(i), y: 5 * v.x))
                                    }
                                }.stroke(Color.blue)

                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    for (i, v) in samples!.enumerated() {
                                        path.addLine(to: CGPoint(x: Double(i), y: 5 * v.y))
                                    }
                                }.stroke(Color.red)
                            }
                        }
                    }
                }
            }
        }
    }

    //  TestingSignal
    //  GApp
    //
    //  Created by Robert Talianu
    //
    struct TestingSignal: View {
        @ObservedObject var viewModel: DataViewModel

        init(_ viewModel: DataViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            Text("Test data:").offset(x: 0, y: -50)
            let tdata: RollingQueue<Sample5D>? = viewModel.dataProvider?.getTestingDataBuffer()
            if tdata != nil && tdata!.size() > 0 {
                ZStack {
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        for (i, v) in tdata!.asList().enumerated() {
                            path.addLine(to: CGPoint(x: Double(i), y: 5 * v.x))
                        }
                    }.stroke(Color.orange)

                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        for (i, v) in tdata!.asList().enumerated() {
                            path.addLine(to: CGPoint(x: Double(i), y: 5 * v.y))
                        }
                    }.stroke(Color.cyan)
                }
            }
        }
    }
    /**
     *
     */
    var body: some View {
        VStack {
            Text("This is Dataview Panel!")

            let dataProvider = viewModel.dataProvider
            if dataProvider != nil {
                Text("Main View Update: \(viewModel.updateCounter)")

                //draw signals
                RecordedSignal(viewModel)

                //draw signals
                TestingSignal(viewModel)
            }

        }.border(Color.red)

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
        self.viewModel.updateCounter += 1
    }

    /**
     *
     */
    public func gestureEvaluationCompleted(_ gw: GestureWindow, _ status: GestureEvaluationStatus) {
        Globals.logToScreen("DataView gestureEvaluationCompleted...")
        //self.viewModel.updateCounter += 1
    }

}

//
// Helper class for DataView that handles the updates
//
// Created by Robert Talianu
//
final class DataViewModel: ObservableObject {
    @Published var dataProvider: RealtimeMultiGestureAnalyser?
    @Published var updateCounter: Int = 1

}
