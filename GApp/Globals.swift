//
//  Globals.swift
//  GApp
//
//  Created by Robert Talianu on 08.10.2024.
//

import Combine

final class Globals: ObservableObject {
    @Published var console: String = "Console Started..."
    
    /**
     */
    func logToScreen(_ message: String) {
        self.console.append("\n\(message)")
        self.console = String(self.console.suffix(200))
    }
}
