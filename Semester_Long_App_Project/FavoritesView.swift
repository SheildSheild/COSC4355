//
//  FavoritesView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Text("Favorites")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top)

            Spacer()

            if favoritesManager.favorites.isEmpty {
                Text("No favorite workouts yet.")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(favoritesManager.favorites, id: \.self) { workout in
                    HStack {
                        Text(workout)
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()

                        // Remove from favorites button
                        Button(action: {
                            favoritesManager.remove(workout)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .listRowBackground(darkGray2) // Dark background for list items
                }
                .background(darkGray3)
                .scrollContentBackground(.hidden)
            }

            Spacer()
        }
        .background(darkGray3.ignoresSafeArea())
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager()) // Mock data
}
