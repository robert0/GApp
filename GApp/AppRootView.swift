//
//  ContentView.swift
//  GApp
//
//  Created by Robert Talianu on 03.10.2024.
//

import SwiftUI

struct AppRootView: View {
    @StateObject var globals = Globals()

    var body: some View {
        TabView(
            selection: .constant(1)
        ) {
            let av = AppTabView().environmentObject(globals)
            av.tabItem {
                Text("App")
            }.tag(1)

            let lv = LogView().environmentObject(globals)
            lv.tabItem {
                Text("Logs")
            }.tag(2)

            BTView().tabItem {
                Text("Bluetooth")
            }.tag(3)
        }

    }
}

#Preview {
    AppRootView()
}
