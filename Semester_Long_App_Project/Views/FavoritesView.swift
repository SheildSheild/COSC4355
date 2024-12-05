import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @StateObject private var viewModel = ExerciseViewModel()

    @State private var selectedTab = 0 // 0 for Exercises, 1 for Workouts

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let accentColor = Color(red: 255 / 255, green: 133 / 255, blue: 26 / 255)

    var body: some View {
        ZStack {
            // Background color that fills entire screen
            darkGray3.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Favorites")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)
                
                Picker("", selection: $selectedTab) {
                    Text("Exercises").tag(0)
                    Text("Workouts").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Spacer()
                
                if selectedTab == 0 {
                    // Favorite exercises tab
                    if favoritesManager.favoriteExercises.isEmpty {
                        Text("No favorite exercises yet.")
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                        Spacer()
                    } else {
                        List(favoritesManager.favoriteExercises, id: \.id) { exercise in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(exercise.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    if let description = exercise.description {
                                        Text(description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                
                                // Remove from favorites button
                                Button(action: {
                                    favoritesManager.removeExercise(exercise)
                                }) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            .listRowBackground(darkGray2)
                        }
                        .listStyle(PlainListStyle())
                        .background(darkGray3)
                        .scrollContentBackground(.hidden)
                    }
                } else {
                    // Favorite workouts tab
                    if favoritesManager.favoriteWorkouts.isEmpty {
                        Text("No favorite workouts yet.")
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                        Spacer()
                    } else {
                        List(favoritesManager.favoriteWorkouts, id: \.id) { workout in
                            VStack(alignment: .leading) {
                                Text(workout.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(workout.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .listRowBackground(darkGray2)
                        }
                        .listStyle(PlainListStyle())
                        .background(darkGray3)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchExercises() // Ensure the exercises are fetched
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
