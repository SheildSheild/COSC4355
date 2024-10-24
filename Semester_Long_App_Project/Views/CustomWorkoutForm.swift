//
//  CustomWorkoutForm.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/23/24.
//

import SwiftUI

struct CustomWorkoutForm: View {
    @Binding var selectedExercises: [Exercise]
    @Binding var workoutName: String
    @Binding var workoutDescription: String
    var onSave: () -> Void

    // Color scheme
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Text("Create Your Workout")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()

            // Name field
            TextField("Workout Name", text: $workoutName)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            // Description field
            TextField("Workout Description (Optional)", text: $workoutDescription)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            // Display selected exercises
            List(selectedExercises, id: \.id) { exercise in
                Text(exercise.name)
                    .foregroundColor(.white)
            }
            .scrollContentBackground(.hidden)
            .background(darkGray3.ignoresSafeArea())

            Spacer()

            // Save button
            Button(action: {
                onSave()
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
            .padding(.bottom, 20)
            .disabled(workoutName.isEmpty)
        }
        .padding(.bottom, 20)
        .background(darkGray3.ignoresSafeArea())
    }
}

#Preview {
    CustomWorkoutForm(
        selectedExercises: .constant([Exercise(id: 1, name: "Push-Up", description: "A great upper body exercise.", duration: 15, category: 10, language: 2, muscles: [1, 4])]),
        workoutName: .constant(""),
        workoutDescription: .constant(""),
        onSave: {}
    )
}
