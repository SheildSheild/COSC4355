//
//  CreateCustomWorkoutView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct CreateCustomWorkoutView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @State private var selectedExercises: [Exercise] = []
    @State private var workoutName: String = ""
    @State private var workoutDescription: String = ""
    @State private var showWorkoutForm = false

    // Color scheme
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            List(viewModel.exercises, id: \.id) { exercise in
                HStack {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()

                    Button(action: {
                        if selectedExercises.contains(exercise) {
                            selectedExercises.removeAll { $0 == exercise }
                        } else {
                            selectedExercises.append(exercise)
                        }
                    }) {
                        Image(systemName: selectedExercises.contains(exercise) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selectedExercises.contains(exercise) ? .green : .gray)
                    }
                }
                .padding()
                .background(darkGray3)
                .cornerRadius(10)
            }
            .onAppear {
                viewModel.fetchExercises()
            }

            Button(action: {
                showWorkoutForm = true
            }) {
                Text("Create Custom Workout")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(accentColor)
                    .foregroundColor(darkGray3)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .disabled(selectedExercises.isEmpty)
            .sheet(isPresented: $showWorkoutForm) {
                CustomWorkoutForm(
                    selectedExercises: $selectedExercises,
                    workoutName: $workoutName,
                    workoutDescription: $workoutDescription,
                    onSave: saveWorkout
                )
            }
        }
        .background(darkGray3)
        .navigationTitle("Create Workout")
    }

    private func saveWorkout() {
        let totalDuration = selectedExercises.reduce(0) { $0 + ($1.duration ?? 10) }
        
        let newWorkout = CustomWorkout(
            name: workoutName,
            description: workoutDescription,
            duration: totalDuration,
            exercises: selectedExercises
        )
        UserDefaults.standard.saveWorkout(newWorkout)
        selectedExercises.removeAll()
        workoutName = ""
        workoutDescription = ""
    }
}

struct CustomWorkout: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var duration: Int // This will be calculated based on exercises
    var exercises: [Exercise]

    // A method to calculate the total duration based on exercises
    mutating func calculateDuration() {
        let totalDuration = exercises.reduce(into: 0) { $0 + ($1.duration ?? 10) } // Use a default duration if none is provided
        duration = totalDuration
    }
}


extension UserDefaults {
    private enum Keys {
            static let customWorkouts = "customWorkouts"
        }
    
    func saveCustomWorkouts(_ workouts: [CustomWorkout]) {
        if let encoded = try? JSONEncoder().encode(workouts) {
            set(encoded, forKey: Keys.customWorkouts)
        }
    }

    func getCustomWorkouts() -> [CustomWorkout]? {
        if let data = data(forKey: Keys.customWorkouts),
           let decoded = try? JSONDecoder().decode([CustomWorkout].self, from: data) {
            return decoded
        }
        return nil
    }
    
    func saveWorkout(_ workout: CustomWorkout) {
        var workouts = getSavedWorkouts() ?? []
        workouts.append(workout)
        if let encoded = try? JSONEncoder().encode(workouts) {
            set(encoded, forKey: "savedWorkouts")
        }
    }

    func getSavedWorkouts() -> [CustomWorkout]? {
        if let savedData = data(forKey: "savedWorkouts") {
            if let workouts = try? JSONDecoder().decode([CustomWorkout].self, from: savedData) {
                return workouts
            }
        }
        return nil
    }
}

#Preview {
    CreateCustomWorkoutView()
}

