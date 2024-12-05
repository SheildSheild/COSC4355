import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @EnvironmentObject var viewModel: ExerciseViewModel
    @EnvironmentObject var favoritesManager: FavoritesManager // Access the favorites manager
    
    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(exercise.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()

            if let description = exercise.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
            }
            
            // Favorite button
            Button(action: {
                if favoritesManager.containsExercise(exercise) {
                    favoritesManager.removeExercise(exercise)
                } else {
                    favoritesManager.addExercise(exercise)
                }
            }) {
                HStack {
                    Image(systemName: favoritesManager.containsExercise(exercise) ? "star.fill" : "star")
                        .foregroundColor(favoritesManager.containsExercise(exercise) ? .yellow : .gray)
                    Text(favoritesManager.containsExercise(exercise) ? "Remove from Favorites" : "Add to Favorites")
                        .foregroundColor(.white)
    
                }
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .background(darkGray3.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ExerciseDetailView(exercise: Exercise(id: 1, name: "Push-Up", description: "A bodyweight exercise for upper body strength.", duration: 15, category: 10, language: 2, muscles: [1, 4]))
        .environmentObject(ExerciseViewModel()) // Provide the view model to the preview
        .environmentObject(FavoritesManager())
}
