//
//  DevnoteApp.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import SwiftUI

@main
struct DevnoteApp: App {
    let persistenceController = PersistenceController.shared
  @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? . dark : .light)
          // MANAGED OBJECT CONTEXT
        }
    }
}
