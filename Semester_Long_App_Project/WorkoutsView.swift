//
//  WorkoutsView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct WorkoutsView: View {
    let exercises = ["Push-Ups", "Squats", "Burpees", "Plank", "Lunges", "Sit-Ups", "Deadlifts"]
    @EnvironmentObject var favoritesManager: FavoritesManager

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Text("Workouts Catalog")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            List(exercises, id: \.self) { exercise in
                HStack {
                    Text(exercise)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()

                    // Favorite button
                    Button(action: {
                        if favoritesManager.contains(exercise) {
                            favoritesManager.remove(exercise)
                        } else {
                            favoritesManager.add(exercise)
                        }
                    }) {
                        Image(systemName: favoritesManager.contains(exercise) ? "star.fill" : "star")
                            .foregroundColor(favoritesManager.contains(exercise) ? .yellow : .gray)
                    }
                }
                .listRowBackground(darkGray2)
            }
            .background(darkGray3)
            .scrollContentBackground(.hidden)
        }
        .background(darkGray3.ignoresSafeArea())
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(FavoritesManager()) // Inject favorites manager
}
