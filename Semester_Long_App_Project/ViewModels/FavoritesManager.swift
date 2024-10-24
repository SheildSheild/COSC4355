//
//  FavoritesManager.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    // Published property to store the list of favorite workouts and exercises
    @Published var favoriteWorkouts: [CustomWorkout] = [] {
        didSet { saveFavorites() }
    }
    @Published var favoriteExercises: [Exercise] = [] {
        didSet { saveFavorites() }
    }

    init() {
        loadFavorites()
    }

    // Function to check if a workout or exercise is in favorites
    func containsWorkout(_ workout: CustomWorkout) -> Bool {
        return favoriteWorkouts.contains { $0.id == workout.id }
    }

    func containsExercise(_ exercise: Exercise) -> Bool {
        return favoriteExercises.contains { $0.id == exercise.id }
    }

    // Add or remove workouts/exercises
    func addWorkout(_ workout: CustomWorkout) {
        if !containsWorkout(workout) {
            favoriteWorkouts.append(workout)
        }
    }

    func addExercise(_ exercise: Exercise) {
        if !containsExercise(exercise) {
            favoriteExercises.append(exercise)
        }
    }

    func removeWorkout(_ workout: CustomWorkout) {
        favoriteWorkouts.removeAll { $0.id == workout.id }
    }

    func removeExercise(_ exercise: Exercise) {
        favoriteExercises.removeAll { $0.id == exercise.id }
    }

    // Save and load from UserDefaults
    private func saveFavorites() {
        if let encodedWorkouts = try? JSONEncoder().encode(favoriteWorkouts),
           let encodedExercises = try? JSONEncoder().encode(favoriteExercises) {
            UserDefaults.standard.set(encodedWorkouts, forKey: "favoriteWorkouts")
            UserDefaults.standard.set(encodedExercises, forKey: "favoriteExercises")
        }
    }

    private func loadFavorites() {
        if let savedWorkoutsData = UserDefaults.standard.data(forKey: "favoriteWorkouts"),
           let savedExercisesData = UserDefaults.standard.data(forKey: "favoriteExercises"),
           let decodedWorkouts = try? JSONDecoder().decode([CustomWorkout].self, from: savedWorkoutsData),
           let decodedExercises = try? JSONDecoder().decode([Exercise].self, from: savedExercisesData) {
            favoriteWorkouts = decodedWorkouts
            favoriteExercises = decodedExercises
        }
    }
}
