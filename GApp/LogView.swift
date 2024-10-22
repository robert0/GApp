//
//  LogWg.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI

struct LogView: View {
    @EnvironmentObject var globals: Globals
    var localStr: String = "Hello, World!"

    init() {
        //globals.logger.info("LogView.init()")
        //globals.logToScreen("This is a test log...")
    }

    // The logs panel
    var body: some View {
        return VStack {
            Spacer()
            Text(globals.console).scrollIndicators(.visible)
        }
    }
}
