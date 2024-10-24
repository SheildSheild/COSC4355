//
//  SavedWorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/22/24.
//

import SwiftUI

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
                    .listRowBackground(darkGray2.ignoresSafeArea())
                }
                .background(darkGray3.ignoresSafeArea())
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
            print("Loaded Workouts: \(workouts)") // Debugging line
            savedWorkouts = workouts
        } else {
            print("No workouts found.") // Debugging line
        }
    }

}

#Preview {
    SavedWorkoutsView()
}
