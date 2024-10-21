//
//  HomePageView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Your Fitness Journey")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top)
                
                Spacer()

                // Workouts Button
                NavigationLink(destination: WorkoutsView()) {
                    Text("Browse Workouts")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(accentColor)
                        .foregroundColor(darkGray3)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                // Create Custom Workout Button
                NavigationLink(destination: CreateCustomWorkoutView()) {
                    Text("Create Custom Workout")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(accentColor)
                        .foregroundColor(darkGray3)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                // Favorites Button
                NavigationLink(destination: FavoritesView()) {
                    Text("Your Favorites")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(accentColor)
                        .foregroundColor(darkGray3)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                Spacer()
            }
            .background(darkGray3.ignoresSafeArea())
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject(FavoritesManager()) // Inject environment object for preview
}
