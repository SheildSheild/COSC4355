//
//  WorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = ExerciseViewModel() // Assume the ExerciseViewModel is already implemented
    @State private var searchText = ""
    @State private var selectedBodyPart: Int? = nil // Filter by category (body part)

    // Example body parts mapped to category IDs
    let bodyParts = [
        "All": nil,
        "Chest": 10,
        "Legs": 8,
        "Back": 12,
        "Arms": 13,
        "Shoulders": 14
    ]

    var filteredExercises: [Exercise] {
        viewModel.exercises.filter { exercise in
            (selectedBodyPart == nil || exercise.category == selectedBodyPart) &&
            (searchText.isEmpty || exercise.name.lowercased().contains(searchText.lowercased()))
        }
    }

    var body: some View {
        VStack {
            // Search bar
            TextField("Search exercises", text: $searchText)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)

            // Body part filter picker
            Picker("Select body part", selection: $selectedBodyPart) {
                ForEach(bodyParts.keys.sorted(), id: \.self) { bodyPart in
                    Text(bodyPart)
                        .tag(bodyParts[bodyPart] ?? nil) // Fixed the issue here
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Exercises list
            List(filteredExercises, id: \.id) { exercise in
                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text(exercise.description ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Workouts")
        .onAppear {
            viewModel.fetchExercises() // Fetch exercises from the API when the view appears
        }
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(FavoritesManager())
}
