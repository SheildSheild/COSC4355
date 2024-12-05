//
//  CustomWorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/23/24.
//

import SwiftUI

struct CustomWorkoutsView: View {
    @State private var customWorkouts: [CustomWorkout] = []
    @EnvironmentObject var favoritesManager: FavoritesManager // To manage favorites

    let darkGray3 = Color(red: 49 / 255, green: 49 / 255, blue: 49 / 255)
    let accentColor = Color(red: 255 / 255, green: 133 / 255, blue: 26 / 255)

    var body: some View {
        NavigationView {
            VStack {
                // NavigationLink for Create Custom Workout
                NavigationLink(destination: CreateCustomWorkoutView()) {
                    Text("Create a Custom Workout")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(accentColor)
                        .foregroundColor(darkGray3)
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                }

                // List of saved custom workouts
                if customWorkouts.isEmpty {
                    Text("No custom workouts saved.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(customWorkouts, id: \.id) { workout in
                            HStack {
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    VStack(alignment: .leading) {
                                        Text(workout.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("Duration: \(workout.duration) mins")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()

                                // Favorite button
                                Button(action: {
                                    if favoritesManager.containsWorkout(workout) {
                                        favoritesManager.removeWorkout(workout)
                                    } else {
                                        favoritesManager.addWorkout(workout)
                                    }
                                }) {
                                    Image(systemName: favoritesManager.containsWorkout(workout) ? "star.fill" : "star")
                                        .foregroundColor(favoritesManager.containsWorkout(workout) ? .yellow : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // Prevents the button from triggering the NavigationLink
                            }
                            .padding()
                            .background(darkGray3)
                            .cornerRadius(10)
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                    .listStyle(PlainListStyle())
                    .background(darkGray3)
                }
            }
            .navigationTitle("Custom Workouts")
            .padding()
            .background(darkGray3.ignoresSafeArea())
        }
        .onAppear {
            loadCustomWorkouts() // Load saved workouts from storage
        }
    }

    private func loadCustomWorkouts() {
        if let workouts = UserDefaults.standard.getCustomWorkouts() {
            customWorkouts = workouts
        }
    }

    func deleteWorkout(at offsets: IndexSet) {
        customWorkouts.remove(atOffsets: offsets)
        UserDefaults.standard.saveCustomWorkouts(customWorkouts)
    }
}

struct WorkoutDetailView: View {
    let workout: CustomWorkout // Expecting a valid CustomWorkout object

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Display workout name
            Text(workout.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.accentColor)
                .padding()

            // Display workout duration
            Text("Duration: \(workout.duration) mins")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Divider()
                .padding(.horizontal)

            // Display exercises in the workout
            Text("Exercises")
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding(.horizontal)

            ForEach(workout.exercises, id: \.id) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.subheadline)
                        .foregroundColor(.white)

                    Text("Sets: \(exercise.muscles.count), Reps: \(exercise.duration ?? 0)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }

            Spacer()
        }
        .padding()
        .background(Color(red: 49 / 255, green: 49 / 255, blue: 49 / 255))
        .cornerRadius(10)
    }
}


#Preview {
    CustomWorkoutsView()
}
