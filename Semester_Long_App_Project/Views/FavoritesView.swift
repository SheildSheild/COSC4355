//
//  FavoritesView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @StateObject private var viewModel = ExerciseViewModel()

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)

    var favoriteExercises: [Exercise] {
        return viewModel.exercises.filter { favoritesManager.contains($0.name) }
    }

    var body: some View {
        VStack {
            Text("Favorite Exercises")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            if favoriteExercises.isEmpty {
                Text("No favorite exercises yet.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(favoriteExercises) { exercise in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            if let description = exercise.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()

                        // Button to remove from favorites
                        Button(action: {
                            favoritesManager.remove(exercise.name)
                        }) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                    .listRowBackground(darkGray2)
                }
                .background(darkGray3)
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            viewModel.fetchExercises() // Ensure the exercises are fetched
        }
        .background(darkGray3.ignoresSafeArea())
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
