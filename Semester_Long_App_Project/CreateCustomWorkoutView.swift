//
//  CreateCustomWorkoutView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct CreateCustomWorkoutView: View {
    @State private var selectedExercises: [String] = []
    @State private var workoutName = ""
    @State private var workoutDescription = ""
    
    let exercises = ["Push-Ups", "Squats", "Burpees", "Plank", "Lunges", "Sit-Ups", "Deadlifts"]
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Text("Create Custom Workout")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            Spacer()

            // Workout name input
            TextField("Workout Name", text: $workoutName)
                .padding()
                .background(darkGray2)
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.horizontal)

            // Workout description input
            TextField("Workout Description", text: $workoutDescription)
                .padding()
                .background(darkGray2)
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.horizontal)

            // Exercise selection list
            List(exercises, id: \.self) { exercise in
                HStack {
                    Text(exercise)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    // Toggle selection for exercises
                    if selectedExercises.contains(exercise) {
                        Image(systemName: "checkmark")
                            .foregroundColor(accentColor)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedExercises.contains(exercise) {
                        selectedExercises.removeAll { $0 == exercise }
                    } else {
                        selectedExercises.append(exercise)
                    }
                }
                .listRowBackground(darkGray2)
            }
            .background(darkGray3)
            .scrollContentBackground(.hidden)

            Spacer()

            // Create workout button
            Button(action: {
                // Handle workout creation logic
            }) {
                Text("Create Workout")
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
}
