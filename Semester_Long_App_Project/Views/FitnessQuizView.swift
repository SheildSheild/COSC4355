//
//  FitnessQuizView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct FitnessQuizView: View {
    @State private var selectedGoal: String? = nil
    @State private var selectedExperience: String? = nil
    @State private var selectedPreference: String? = nil
    @State private var isQuizCompleted: Bool = false

    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            if !isQuizCompleted {
                Text("Fitness Assessment")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)

                Spacer()

                Text("What is your main fitness goal?")
                    .font(.headline)
                    .foregroundColor(.white)
                Picker(selection: $selectedGoal, label: Text("")) {
                    Text("Build Muscle").tag("Muscle")
                    Text("Lose Weight").tag("Weight Loss")
                    Text("Improve Endurance").tag("Endurance")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(darkGray1)
                .cornerRadius(8)

                Text("How experienced are you in working out?")
                    .font(.headline)
                    .foregroundColor(.white)
                Picker(selection: $selectedExperience, label: Text("")) {
                    Text("Beginner").tag("Beginner")
                    Text("Intermediate").tag("Intermediate")
                    Text("Advanced").tag("Advanced")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(darkGray1)
                .cornerRadius(8)

                Text("What kind of workouts do you prefer?")
                    .font(.headline)
                    .foregroundColor(.white)
                Picker(selection: $selectedPreference, label: Text("")) {
                    Text("Weight Training").tag("Weights")
                    Text("Bodyweight").tag("Bodyweight")
                    Text("Cardio").tag("Cardio")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(darkGray1)
                .cornerRadius(8)

                Spacer()

                Button(action: {
                    isQuizCompleted = true
                }) {
                    Text("See Your Workouts")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(accentColor)
                        .foregroundColor(darkGray3)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
            }
        }
        .padding()
        .background(darkGray3.ignoresSafeArea())
        .fullScreenCover(isPresented: $isQuizCompleted) {
            // Present MainTabView as a full screen modal, with no option to go back
            MainTabView(
                selectedGoal: selectedGoal,
                selectedExperience: selectedExperience,
                selectedPreference: selectedPreference
            )
            .environmentObject(FavoritesManager()) // Provide FavoritesManager if needed
        }
    }
}

#Preview {
    FitnessQuizView()
}
