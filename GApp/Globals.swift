//
//  Globals.swift
//  GApp
//
//  Created by Robert Talianu
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
