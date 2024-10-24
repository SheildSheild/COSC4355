//
//  HomePageView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @StateObject private var viewModel = ExerciseViewModel()
    
    let selectedGoal: String?
    let selectedExperience: String?
    let selectedPreference: String?

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Text("Welcome to Your Gym App")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            // Display user's quiz results
            VStack(alignment: .leading, spacing: 8) {
                if let goal = selectedGoal {
                    Text("Goal: \(goal)").foregroundColor(.white)
                }
                if let experience = selectedExperience {
                    Text("Experience: \(experience)").foregroundColor(.white)
                }
                if let preference = selectedPreference {
                    Text("Preference: \(preference)").foregroundColor(.white)
                }
            }
            .padding(.top)

            // Curated Workouts Section
            VStack(alignment: .leading) {
                Text("Curated Workouts")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)

                if viewModel.exercises.isEmpty {
                    Text("No curated workouts yet.")
                        .foregroundColor(.gray)
                        .padding(.top)
                } else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.exercises.prefix(5)) { exercise in
                                VStack {
                                    Text(exercise.name)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(darkGray2)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(darkGray3)
        .onAppear {
            viewModel.fetchExercises() // Fetch exercises to show curated workouts
        }
    }
}

#Preview {
    HomePageView(selectedGoal: "Muscle", selectedExperience: "Intermediate", selectedPreference: "Weights")
        .environmentObject(FavoritesManager())
}

