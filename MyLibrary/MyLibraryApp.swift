//
//  MyLibraryApp.swift
//  MyLibrary
//
//  Created by Nicoly Figueredo on 03/07/23.
//

import SwiftUI

@main
struct MyLibraryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
