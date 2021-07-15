//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Huxley McGuffin on 14/7/21.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @ObservedObject private var data = ScrumData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums, saveAction: data.save)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear() {
                data.load()
            }
        }
    }
}
