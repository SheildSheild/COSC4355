//
//  ExerciseViewModel.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var exerciseImages: [Int: [ExerciseImage]] = [:]
    @Published var categoryImages: [Int: [ExerciseImage]] = [:] // Map category to images
    @Published var isLoading = false

    let apiKey = "5162cd7f47cb78a1df2726264303221507692d5a"
    let exerciseBaseURL = "https://wger.de/api/v2/exercise/?language=2"
    let imageBaseURL = "https://wger.de/api/v2/exerciseimage/"
    
    func fetchExercises() {
        guard !isLoading else { return } // Avoid multiple requests at once
        isLoading = true
        
        guard let exerciseURL = URL(string: exerciseBaseURL) else { return }

        var request = URLRequest(url: exerciseURL)
        request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { self.isLoading = false }
            
            if let error = error {
                print("Error fetching exercises: \(error)")
                return
            }
            guard let data = data else { return }

            do {
                let exerciseResponse = try JSONDecoder().decode(ExerciseResponse.self, from: data)
                DispatchQueue.main.async {
                    self.exercises = exerciseResponse.results
                    self.fetchExerciseImages() // Fetch images after exercises
                }
            } catch {
                print("Error decoding exercises: \(error)")
            }
        }

        task.resume()
    }
    
    func fetchExerciseImages() {
            guard let imageURL = URL(string: imageBaseURL) else { return }
            
            var request = URLRequest(url: imageURL)
            request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error fetching images: \(error)")
                    return
                }
                guard let data = data else { return }

                do {
                    let imageResponse = try JSONDecoder().decode(ExerciseImageResponse.self, from: data)
                    DispatchQueue.main.async {
                        for image in imageResponse.results {
                            // Map exercise_id to its images
                            self.exerciseImages[image.exercise] = self.exerciseImages[image.exercise, default: []] + [image]
                        }
                    }
                } catch {
                    print("Error decoding images: \(error)")
                }
            }

            task.resume()
        }
    }




struct Exercise: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let duration: Int? // Optional if duration isn't always provided
    let category: Int
    let language: Int
}


struct ExerciseImage: Identifiable, Codable, Hashable {
    let id: Int
    let image: String
    let exercise: Int // This should refer to the exercise ID, not the category
}

struct ExerciseResponse: Codable {
    let results: [Exercise]
    let next: String?
}

struct ExerciseImageResponse: Codable {
    let results: [ExerciseImage]
}
