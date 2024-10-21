//
//  GetStartedView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 10/21/24.
//

import SwiftUI

struct GetStartedView: View {
    // Define color palette based on user preferences
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack {
            Spacer()

            Text("BUILD YOUR PERFECT BODY")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Spacer()

            Button(action: {
                // Navigate to fitness quiz view
            }) {
                Text("GET STARTED")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(accentColor)
                    .foregroundColor(darkGray3)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }

            Button(action: {
                // Navigate to login view (if applicable)
            }) {
                Text("I ALREADY HAVE AN ACCOUNT")
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundColor(accentColor)
                    .padding(.horizontal, 20)
            }

            Spacer()
        }
        .background(darkGray3.ignoresSafeArea()) // Apply dark background
    }
}

#Preview {
    GetStartedView()
}
