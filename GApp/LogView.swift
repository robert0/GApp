//
//  LogWg.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI

struct LogView: View {
    @ObservedObject var viewModel = LogViewModel()
    
    // The logs panel
    var body: some View {
        return VStack {
            Spacer()
            Text(viewModel.text)
        }
    }
        
    // The logs panel
    func logCallbackFunction(_ message:String) {
        self.viewModel.text = message
    }
}

final class LogViewModel: ObservableObject {
    @Published var text = "UI Logging Initialized..."
}
