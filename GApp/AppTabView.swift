//
//  AppTabView.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI

struct AppTabView: View {
    @EnvironmentObject var globals: Globals
    
    // The app panel
    var body: some View {
        return VStack {
            //add buttons
            HStack  {
                Spacer ()
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
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Spacer ()
            }
            
            //add data view panel
            DataView()
            
        }
    }
}
