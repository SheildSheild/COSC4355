//
//  Semester_Long_App_ProjectApp.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/18/24.
//

import SwiftUI

@main
struct Semester_Long_App_ProjectApp: App {
    @StateObject private var favoritesManager = FavoritesManager() // Initialize FavoritesManager

    var body: some Scene {
        WindowGroup {
            GetStartedView()
                .environmentObject(favoritesManager)
                .environmentObject(ExerciseViewModel())// Inject it into the environment
        }
    }
}
