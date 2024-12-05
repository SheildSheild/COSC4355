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

                if selectedTab == 0 {
                    // Exercise Favorites
                    if favoritesManager.favoriteExercises.isEmpty {
                        Spacer()
                        Text("No favorite exercises yet.")
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        List(favoritesManager.favoriteExercises, id: \.id) { exercise in
                            HStack {
                                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
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
                                }
                                Spacer()
                                Button(action: {
                                    favoritesManager.removeExercise(exercise)
                                }) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // Ensures button only handles tap
                            }
                            .listRowBackground(darkGray2)
                        }
                        .listStyle(PlainListStyle())
                        .background(darkGray3)
                    }
                } else {
                    // Workout Favorites
                    if favoritesManager.favoriteWorkouts.isEmpty {
                        Spacer()
                        Text("No favorite workouts yet.")
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        List(favoritesManager.favoriteWorkouts, id: \.id) { workout in
                            HStack {
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    VStack(alignment: .leading) {
                                        Text(workout.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(workout.description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Button(action: {
                                    favoritesManager.removeWorkout(workout)
                                }) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // Ensures button only handles tap
                            }
                            .listRowBackground(darkGray2)
                        }
                        .listStyle(PlainListStyle())
                        .background(darkGray3)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchExercises()
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
