//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Huxley McGuffin on 14/7/21.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
