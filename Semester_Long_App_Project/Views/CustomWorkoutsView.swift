//
//  CustomWorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/23/24.
//

import SwiftUI

struct CustomWorkoutsView: View {
    @State private var customWorkouts: [CustomWorkout] = []

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

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
                            VStack(alignment: .leading) {
                                Text(workout.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Duration: \(workout.duration) mins")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
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


#Preview {
    CustomWorkoutsView()
}
