//
//  DaySchedulizApp.swift
//  DayScheduliz
//
//  Created by Mirzabek on 07/06/23.
//

import SwiftUI

@main
struct DaySchedulizApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
