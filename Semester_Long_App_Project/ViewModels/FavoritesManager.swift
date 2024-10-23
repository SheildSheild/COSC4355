//
//  FavoritesManager.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    // Published property to store the list of favorite workouts
    @Published var favorites: [String] {
        didSet {
            // Save the updated favorites list to UserDefaults
            saveFavorites()
        }
    }

    init() {
        // Load favorites from UserDefaults upon initialization
        self.favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
    }

    // Function to check if a workout is already in favorites
    func contains(_ workout: String) -> Bool {
        return favorites.contains(workout)
    }

    // Function to add a workout to favorites
    func add(_ workout: String) {
        if !favorites.contains(workout) {
            favorites.append(workout)
        }
    }

    // Function to remove a workout from favorites
    func remove(_ workout: String) {
        favorites.removeAll { $0 == workout }
    }

    // Save favorites to UserDefaults
    private func saveFavorites() {
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
}
