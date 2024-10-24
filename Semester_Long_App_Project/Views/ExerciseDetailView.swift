import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @EnvironmentObject var viewModel: ExerciseViewModel

    // Color palette
    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Exercise Name
            Text(exercise.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(accentColor) // Accent color for title
                .padding(.top)

            // Exercise Description
            if let description = exercise.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.white) // White text for description
                    .padding(.top, 10)
            }

            // Display exercise images based on category
            if let images = viewModel.exerciseImages[exercise.id], let image = images.first {
                AsyncImage(url: URL(string: image.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.vertical, 10)
            } else {
                Text("No images available")
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity) // Ensures full width
        .background(darkGray3.ignoresSafeArea()) // Ensures background goes to edges
        .navigationTitle("") // Remove the duplicated title from the navigation bar
        .navigationBarTitleDisplayMode(.inline) // Use inline mode for navigation title
    }
}

#Preview {
    ExerciseDetailView(exercise: Exercise(id: 1, name: "Push-Up", description: "A bodyweight exercise for upper body strength.", duration: 15, category: 10, language: 2))
        .environmentObject(ExerciseViewModel()) // Provide the view model to the preview
}
