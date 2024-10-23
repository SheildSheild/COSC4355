//
//  MainTabView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    let selectedGoal: String?
    let selectedExperience: String?
    let selectedPreference: String?

    var body: some View {
        TabView {
            // Home Tab
            HomePageView(
                selectedGoal: selectedGoal,
                selectedExperience: selectedExperience,
                selectedPreference: selectedPreference
            )
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // Workouts Tab
            WorkoutsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Workouts")
                }

            // Create Custom Workout Tab
            CreateCustomWorkoutView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Create Workout")
                }

            // Favorites Tab
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
        .accentColor(accentColor) // Set the accent color for the tab icons and text
    }
}

#Preview {
    MainTabView(
        selectedGoal: "Muscle",
        selectedExperience: "Intermediate",
        selectedPreference: "Weights"
    )
    .environmentObject(FavoritesManager()) // Provide the FavoritesManager environment object
}
