//
//  LogWg.swift
//  GApp
//
//  Created by Robert Talianu on 08.10.2024.
//
import SwiftUI

struct LogView: View {
    @EnvironmentObject var globals: Globals
    
    // The logs panel
    var body: some View {
        return VStack {
            Spacer()
            Text(globals.console).scrollIndicators(.visible)
        }
    }
}
