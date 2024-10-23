//
//  CreateCustomWorkoutView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct CreateCustomWorkoutView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var selectedExercises: [Exercise] = []
    @State private var workoutName: String = ""
    @State private var workoutDescription: String = ""

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Text("Create Custom Workout")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            Form {
                Section(header: Text("Workout Name")) {
                    TextField("Enter workout name", text: $workoutName)
                }

                Section(header: Text("Workout Description")) {
                    TextField("Enter workout description", text: $workoutDescription)
                }

                Section(header: Text("Selected Exercises")) {
                    ForEach(selectedExercises, id: \.self) { exercise in
                        Text(exercise.name)
                            .foregroundColor(.white)
                    }
                }
            }
            .background(darkGray3)

            Spacer()

            Button(action: {
                // Save custom workout logic (you can implement actual saving to persistence here)
                print("Workout saved: \(workoutName)")
            }) {
                Text("Save Workout")
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
        .background(darkGray3.ignoresSafeArea())
    }
}

#Preview {
    CreateCustomWorkoutView()
        .environmentObject(FavoritesManager()) // Provide FavoritesManager if needed
}
