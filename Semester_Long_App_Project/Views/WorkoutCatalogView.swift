//
//  WorkoutCatalogView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct WorkoutCatalogView: View {
    var curatedWorkouts: [String] = ["Chest Day", "Leg Day", "HIIT"]
    var allWorkouts: [String] = ["Chest Day", "Leg Day", "HIIT", "Yoga", "Pilates", "Cycling", "Swimming"]

    @State private var showAllWorkouts = false

    // Define color palette based on user preferences
    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 255 / 255, green: 133 / 255, blue: 26 / 255)

    var body: some View {
        VStack {
            Text(showAllWorkouts ? "All Workouts" : "Curated Workouts")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            Spacer()

            // Display curated or all workouts with dark-themed background
            List(showAllWorkouts ? allWorkouts : curatedWorkouts, id: \.self) { workout in
                HStack {
                    Text(workout)
                        .font(.headline)
                        .foregroundColor(.white) // Text color for dark mode
                    Spacer()

                    // Favorite button (optional for favoriting workouts)
                    Button(action: {
                        // Handle favorite/unfavorite logic here
                    }) {
                        Image(systemName: "star")
                            .foregroundColor(accentColor)
                    }
                }
                .listRowBackground(darkGray2) // Background color for list rows
            }
            .background(darkGray3)
            .scrollContentBackground(.hidden) // Remove default list background
            .cornerRadius(10)

            Spacer()

            // Toggle between curated and all workouts
            Button(action: {
                showAllWorkouts.toggle()
            }) {
                Text(showAllWorkouts ? "Show Curated Workouts" : "Show All Workouts")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(accentColor)
                    .foregroundColor(darkGray3)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .background(darkGray3.ignoresSafeArea()) // Dark background for the entire view
    }
}

#Preview {
    WorkoutCatalogView()
}
