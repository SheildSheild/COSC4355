import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @State private var searchText = ""
    @State private var selectedBodyPart: Int? = nil

    // Define the color palette
    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray2 = Color(red: 65/255, green: 65/255, blue: 65/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    // Example body parts mapped to category IDs
    let bodyParts = [
        "All": nil,
        "Chest": 10,
        "Legs": 8,
        "Back": 12,
        "Arms": 13,
        "Shoulders": 14
    ]

    var filteredExercises: [Exercise] {
        viewModel.exercises.filter { exercise in
            (selectedBodyPart == nil || exercise.category == selectedBodyPart) &&
            (searchText.isEmpty || exercise.name.lowercased().contains(searchText.lowercased()))
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search bar with accent and background color
                TextField("Search exercises", text: $searchText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Picker for body part selection
                Picker("Select body part", selection: $selectedBodyPart) {
                    ForEach(bodyParts.keys.sorted(), id: \.self) { bodyPart in
                        Text(bodyPart)
                            .tag(bodyParts[bodyPart] ?? nil)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(darkGray2) // Dark gray background for picker
                .cornerRadius(8)

                // Exercise list with custom colors
                List(filteredExercises, id: \.id) { exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)
                                    .environmentObject(viewModel)) {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                                .foregroundColor(.white) // White text for exercise name
                            Text(exercise.description ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray) // Gray text for description
                        }
                        .padding()
                        .background(darkGray3) // Dark gray background for each list item
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.bottom, 20) // Padding to ensure no overlap with the tab bar
            }
            .background(darkGray3.ignoresSafeArea()) // Apply background color to whole view
            .navigationTitle("Workouts")
            .foregroundColor(accentColor)
        }
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(FavoritesManager())
}
