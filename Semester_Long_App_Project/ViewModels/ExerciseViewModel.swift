//
//  ExerciseViewModel.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct Exercise: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let category: Int
    let language: Int
}

struct ExerciseResponse: Codable {
    let results: [Exercise]
    let next: String? // Holds the URL to the next page if available
}

struct ExerciseImageResponse: Codable {
    let results: [ExerciseImage]
}

struct ExerciseImage: Identifiable, Codable {
    let id: Int
    let image: String // The URL for the image
}

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var exerciseImages: [Int: [ExerciseImage]] = [:] // Stores images by exercise ID
    @Published var isLoading = false

    let apiKey = "5162cd7f47cb78a1df2726264303221507692d5a"
    let baseURL = "https://wger.de/api/v2/exercise/?language=2"
    let imageURL = "https://wger.de/api/v2/exerciseimage/"
    var nextPageURL: String?

    func fetchExercises() {
        guard !isLoading else { return } // Avoid multiple requests at once
        isLoading = true
        
        let urlString = nextPageURL ?? baseURL
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Error fetching exercises: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let exerciseResponse = try JSONDecoder().decode(ExerciseResponse.self, from: data)
                DispatchQueue.main.async {
                    // Filter exercises based on the criteria
                    let filteredExercises = exerciseResponse.results.filter { exercise in
                        self.isValidExercise(exercise: exercise)
                    }
                    
                    self.exercises.append(contentsOf: filteredExercises)
                    self.nextPageURL = exerciseResponse.next // Update the next page URL for pagination

                    // Fetch images for each filtered exercise
                    for exercise in filteredExercises {
                        self.fetchExerciseImages(exerciseID: exercise.id)
                    }

                    // Automatically fetch the next page if there's one
                    if let nextPage = exerciseResponse.next {
                        self.nextPageURL = nextPage
                        self.fetchExercises() // Fetch the next page
                    }
                }
            } catch {
                print("Error decoding exercises: \(error)")
            }
        }

        task.resume()
    }

    // Check if an exercise meets the filtering criteria
    private func isValidExercise(exercise: Exercise) -> Bool {
        // Exclude exercises that are not in English (language == 2)
        guard exercise.language == 2 else {
            return false
        }

        // Exclude exercises without a description
        guard let description = exercise.description else {
            return false
        }

        // Exclude exercises with HTML in their name or description
        let hasHtmlInName = exercise.name.contains("<") || exercise.name.contains(">")
        let hasHtmlInDescription = description.contains("<") || description.contains(">")

        if hasHtmlInName || hasHtmlInDescription {
            return false
        }

        // Check if the exercise has images
        if let images = exerciseImages[exercise.id], images.isEmpty {
            return false
        }

        return true
    }

    // Fetch images associated with a specific exercise
    func fetchExerciseImages(exerciseID: Int) {
        guard let url = URL(string: "\(imageURL)?exercise=\(exerciseID)") else { return }

        var request = URLRequest(url: url)
        request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching exercise images: \(error)")
                return
            }

            guard let data = data else {
                print("No data received for images")
                return
            }

            do {
                let imageResponse = try JSONDecoder().decode(ExerciseImageResponse.self, from: data)
                DispatchQueue.main.async {
                    self.exerciseImages[exerciseID] = imageResponse.results
                }
            } catch {
                print("Error decoding exercise images: \(error)")
            }
        }

        task.resume()
    }
}
