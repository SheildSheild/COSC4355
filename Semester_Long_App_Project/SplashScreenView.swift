//
//  SplashScreenView.swift
//  Semester_Long_App_Project
//
//  Created by Shield on 12/5/24.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var favoritesManager = FavoritesManager() // Initialize FavoritesManager
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            GetStartedView()
                .environmentObject(favoritesManager)
                .environmentObject(ExerciseViewModel())// Inject it into the environment
        }
        else
        {
            VStack{
                VStack{
                    
                    HStack{
                        ZStack {
                            Image("Screen")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        .frame(width: 1320, height: 2868)
                            
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(width: 450, height: 450)
                            .shadow(color: .white, radius: 8)
                            
                            Text("At Home Fitness")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                                .shadow(color: .white, radius: 4, x: 2, y: 2)
                                .offset(y: 120)
                            
                        }
                        
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    withAnimation {
                        self.isActive = true
                    }
                }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
