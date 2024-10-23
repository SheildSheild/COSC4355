//
//  WorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager

    @State private var selectedBodyPart: Int? = nil

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    // Categories for filtering by body part (replace with real category IDs from API)
    let categories = [
        (id: 8, name: "Upper Body"),  // Replace with actual category IDs from the API
        (id: 9, name: "Lower Body"),
        (id: 10, name: "Core"),
        (id: 11, name: "Full Body")
    ]

    var filteredExercises: [Exercise] {
        return viewModel.exercises.filter { exercise in
            (selectedBodyPart == nil || exercise.category == selectedBodyPart)
        }
    }

    var body: some View {
        VStack {
            // Filters
            HStack {
                Picker("Body Part", selection: $selectedBodyPart) {
                    Text("All").tag(nil as Int?)
                    ForEach(categories, id: \.id) { category in
                        Text(category.name).tag(category.id as Int?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .background(darkGray2)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()

            // Filtered Workouts List
            List(filteredExercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    if let description = exercise.description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .listRowBackground(darkGray2)
            }
            .background(darkGray3)
            .scrollContentBackground(.hidden)
            .onAppear {
                viewModel.fetchExercises() // Fetch exercises when view appears
            }
        }
        .background(darkGray3.ignoresSafeArea())
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(FavoritesManager())
}
