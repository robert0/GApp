//
//  ContentView.swift
//  GApp
//
//  Created by Robert Talianu
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

            let btv = BTView().environmentObject(globals)
            btv.tabItem {
                Text("Bluetooth")
            }.tag(3)
        }

    }



}

#Preview {
    AppRootView()
}
