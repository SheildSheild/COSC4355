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
}

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var isLoading = false

    let apiKey = "5162cd7f47cb78a1df2726264303221507692d5a"
    let baseURL = "https://wger.de/api/v2/exercise/?language=2"
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
                    self.exercises.append(contentsOf: exerciseResponse.results)
                    self.nextPageURL = exerciseResponse.next // Update the next page URL for pagination

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
}

struct ExerciseResponse: Codable {
    let results: [Exercise]
    let next: String? // Holds the URL to the next page if available
}
