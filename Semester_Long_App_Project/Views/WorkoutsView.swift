//
//  WorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager // Access favorites manager
    @State private var searchText = ""
    @State private var selectedMuscle: Int? = nil

    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    let muscles = [
        "All": nil,
        "Chest": 4,
        "Legs": 8,
        "Back": 12,
        "Arms": 13,
        "Shoulders": 14,
        "Abs": 6
    ]

    var filteredExercises: [Exercise] {
        viewModel.exercises.filter { exercise in
            (selectedMuscle == nil || exercise.muscles.contains(selectedMuscle!)) &&
            (searchText.isEmpty || exercise.name.lowercased().contains(searchText.lowercased()))
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search exercises", text: $searchText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Picker("Select muscle group", selection: $selectedMuscle) {
                    ForEach(muscles.keys.sorted(), id: \.self) { muscle in
                        Text(muscle)
                            .tag(muscles[muscle] ?? nil)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Change to a dropdown menu
                .padding()
                .background(darkGray2)
                .cornerRadius(8)

                List(filteredExercises, id: \.id) { exercise in
                    HStack {
                        // Navigation link area
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)
                                        .environmentObject(viewModel)) {
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(exercise.description ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(darkGray3)
                            .cornerRadius(10)
                            .contentShape(Rectangle()) // Explicitly define tappable area for NavigationLink
                        }
                        
                        Spacer()

                        // Favorite button (this should not be tappable by clicking the entire row)
                        Button(action: {
                            if favoritesManager.containsExercise(exercise) {
                                favoritesManager.removeExercise(exercise)
                            } else {
                                favoritesManager.addExercise(exercise)
                            }
                        }) {
                            Image(systemName: favoritesManager.containsExercise(exercise) ? "star.fill" : "star")
                                .foregroundColor(favoritesManager.containsExercise(exercise) ? .yellow : .gray)
                        }
                    }
                    .padding()
                    .background(darkGray3)
                    .cornerRadius(10)
                }

                .listStyle(PlainListStyle())
                .padding(.bottom, 20)
            }
            .background(darkGray3.ignoresSafeArea())
            .navigationTitle("Workouts")
            .onAppear {
                viewModel.fetchExercises()
            }
        }
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(FavoritesManager())
}
