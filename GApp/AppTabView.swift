//
//  AppTabView.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI

struct AppTabView: View {
    @EnvironmentObject var globals: Globals

    private var mlistener: MockListenerHander = MockListenerHander()
    private var dataView: DataView = DataView()

    // The app panel
    var body: some View {
        return VStack {
            //add buttons
            HStack {
                Spacer()
                Button("First") {
                    globals.logToScreen("First Button Pressed")
                }
                Button("Second") {
                    globals.logToScreen("Second Button Pressed")
                }
                Button("Third") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Button("Test") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Button("Mock") {
                    //MockGenerator.toggleListener()
                    globals.logger.log("Mock Button Pressed")
                    globals.logToScreen("Mock Button Pressed")
                    MockGenerator.toggleListener(mlistener)
                }
                Spacer()
            }

            //add data view panel
            dataView
        }
    }

    init() {
        mlistener.setViewUpdateListener(dataView)
    }
}
