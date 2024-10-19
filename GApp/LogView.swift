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
    
    // The logs panel
    var body: some View {
        return VStack {
            Spacer()
            Text(globals.console).scrollIndicators(.visible)
        }
    }
}
