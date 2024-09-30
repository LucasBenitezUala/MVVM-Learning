//
//  LearningMVVMApp.swift
//  LearningMVVM
//
//  Created by Lucas Emiliano Benitez Joncic on 30/09/2024.
//

import SwiftUI
import SwiftData

@main
struct LearningMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Task.self])  // Simplifica la configuración del modelo
        }
    }
}
