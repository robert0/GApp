//
//  Globals.swift
//  GApp
//
//  Created by Robert Talianu
//

import Combine
import Foundation
import os

final class Globals: ObservableObject {
    @Published var console: String = "Console Started..."
    @Published var logger = Logger(
        //        subsystem: Bundle.main.bundleIdentifier!,
        //        category: String(describing: ProductsViewModel.self)
        )

    
    /**
     * Constructor
     */
    init() {
        logger.info("Application Started!...")
    }

    /**
     *
     */
    func logToScreen(_ message: String) {
        self.console.append("\n\(message)")
        self.console = String(self.console.suffix(200))
    }

}
