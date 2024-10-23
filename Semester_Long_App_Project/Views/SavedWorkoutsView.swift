//
//  SavedWorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/22/24.
//

import SwiftUI

// Define the CustomWorkout struct
struct CustomWorkout: Identifiable, Codable, Hashable {
    var id = UUID() // Unique identifier for the workout
    var name: String
    var description: String
    var exercises: [Exercise] // Assuming `Exercise` is already defined
}

// Extend UserDefaults for saving and retrieving workouts
extension UserDefaults {
    private static let savedWorkoutsKey = "savedWorkouts"

    func saveWorkouts(_ workouts: [CustomWorkout]) {
        if let encoded = try? JSONEncoder().encode(workouts) {
            set(encoded, forKey: UserDefaults.savedWorkoutsKey)
        }
    }

    func getSavedWorkouts() -> [CustomWorkout]? {
        if let savedData = data(forKey: UserDefaults.savedWorkoutsKey),
           let decoded = try? JSONDecoder().decode([CustomWorkout].self, from: savedData) {
            return decoded
        }
        return nil
    }
}

struct SavedWorkoutsView: View {
    @State private var savedWorkouts: [CustomWorkout] = []

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)

    var body: some View {
        VStack {
            Text("Saved Workouts")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            if savedWorkouts.isEmpty {
                Text("No saved workouts.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(savedWorkouts, id: \.id) { workout in
                    VStack(alignment: .leading) {
                        Text(workout.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(workout.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        ForEach(workout.exercises, id: \.id) { exercise in
                            Text("- \(exercise.name)")
                                .foregroundColor(.gray)
                        }
                    }
                    .listRowBackground(darkGray2)
                }
                .background(darkGray3)
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            loadSavedWorkouts()
        }
        .background(darkGray3.ignoresSafeArea())
    }

    private func loadSavedWorkouts() {
        if let workouts = UserDefaults.standard.getSavedWorkouts() {
            savedWorkouts = workouts
        }
    }
}

#Preview {
    SavedWorkoutsView()
}
