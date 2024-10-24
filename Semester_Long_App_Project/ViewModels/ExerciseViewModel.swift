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
    @Published var isLoading = false

    let apiKey = "5162cd7f47cb78a1df2726264303221507692d5a"
    let exerciseBaseURL = "https://wger.de/api/v2/exercise/?language=2"
    let imageBaseURL = "https://wger.de/api/v2/exerciseimage/"

    // Fetch exercises with an optional URL parameter
    func fetchExercises(urlString: String? = nil) {
        guard !isLoading else { return } // Avoid multiple requests at once
        isLoading = true
        
        // Use the provided URL string or default to the base URL
        let urlToFetch = urlString ?? exerciseBaseURL
        guard let exerciseURL = URL(string: urlToFetch) else { return }

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
                    // Filter out non-English exercises manually
                    let englishExercises = exerciseResponse.results.filter { $0.language == 2 }
                    self.exercises.append(contentsOf: englishExercises.map { exercise in
                        var cleanedExercise = exercise
                        cleanedExercise.description = exercise.description?.stripHTML // Clean up HTML
                        return cleanedExercise
                    })
                    
                    // If there's a next page, fetch it
                    if let nextPageURL = exerciseResponse.next {
                        self.fetchExercises(urlString: nextPageURL)
                    }
                    
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

extension String {
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

struct Exercise: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    var description: String?
    let duration: Int?
    let category: Int
    let language: Int
    let muscles: [Int]
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
