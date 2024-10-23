//
//  ExerciseDetailView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/23/24.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @EnvironmentObject var viewModel: ExerciseViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(exercise.name)
                .font(.largeTitle)
                .bold()
                .padding(.top)

            if let description = exercise.description {
                Text(description)
                    .font(.body)
                    .padding(.top, 10)
            }

            // Display exercise images if available
            if let images = viewModel.exerciseImages[exercise.id], !images.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(images) { image in
                            AsyncImage(url: URL(string: image.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
            } else {
                Text("No images available")
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(exercise.name)
    }
}

#Preview {
    // Adding the 'language' parameter to fix the missing argument issue
    ExerciseDetailView(exercise: Exercise(id: 1, name: "Push-Up", description: "A bodyweight exercise for upper body strength.", category: 10, language: 2))
        .environmentObject(ExerciseViewModel()) // Provide the view model
}
