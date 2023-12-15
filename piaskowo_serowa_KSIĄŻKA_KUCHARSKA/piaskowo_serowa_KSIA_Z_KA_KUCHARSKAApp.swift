//
//  piaskowo_serowa_KSIA_Z_KA_KUCHARSKAApp.swift
//  piaskowo_serowa_KSIĄŻKA_KUCHARSKA
//
//  Created by apple on 09/06/2023.
//

import SwiftUI

@main
struct piaskowo_serowa_KSIA_Z_KA_KUCHARSKAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
