import SwiftUI

struct FitnessQuizView: View {
    @State private var selectedGoal: String? = nil
    @State private var selectedExperience: String? = nil
    @State private var selectedPreference: String? = nil
    @State private var isQuizCompleted: Bool = false

    let darkGray1 = Color(red: 82/255, green: 82/255, blue: 82/255)
    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)
    let backgroundColor = Color(red: 36/255, green: 36/255, blue: 36/255)

    var body: some View {
        VStack {
            if !isQuizCompleted {
                VStack(spacing: 16) {
                    Text("Fitness Assessment")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(accentColor)

                    ProgressView(value: 0.66)
                        .progressViewStyle(LinearProgressViewStyle(tint: accentColor))
                        .padding(.horizontal)
                    
                    Spacer()

                    Group {
                        quizSection(title: "Your fitness goal?", options: ["Muscle", "Weight Loss", "Endurance"], selection: $selectedGoal)
                        quizSection(title: "Your experience level?", options: ["Beginner", "Intermediate", "Advanced"], selection: $selectedExperience)
                        quizSection(title: "Workout preference?", options: ["Weights", "Bodyweight", "Cardio"], selection: $selectedPreference)
                    }
                    .padding(.horizontal)

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
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
                .padding()
                .background(backgroundColor)
            }
        }
        .fullScreenCover(isPresented: $isQuizCompleted) {
            MainTabView(
                selectedGoal: selectedGoal,
                selectedExperience: selectedExperience,
                selectedPreference: selectedPreference
            )
            .environmentObject(FavoritesManager())
        }
    }
    
    func quizSection(title: String, options: [String], selection: Binding<String?>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Picker(selection: selection, label: Text("")) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option as String?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(darkGray1)
            .cornerRadius(8)
        }
    }
}

#Preview {
    FitnessQuizView()
}
