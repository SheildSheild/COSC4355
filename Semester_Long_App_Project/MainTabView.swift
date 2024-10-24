import SwiftUI

struct CustomTabBarViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(Color(red: 49/255, green: 49/255, blue: 49/255)) // Custom dark gray color
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance // For iOS 15 and later
            }
    }
}

struct MainTabView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    let darkGray3 = Color(red: 49/255, green: 49/255, blue: 49/255)
    let accentColor = Color(red: 253/255, green: 175/255, blue: 123/255)

    let selectedGoal: String?
    let selectedExperience: String?
    let selectedPreference: String?

    var body: some View {
        TabView {
            // Home Tab
            HomePageView(
                selectedGoal: selectedGoal,
                selectedExperience: selectedExperience,
                selectedPreference: selectedPreference
            )
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // Workouts Tab
            WorkoutsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Workouts")
                }

            // Create Custom Workout Tab
            CreateCustomWorkoutView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Create Workout")
                }

            // Favorites Tab
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
        .accentColor(accentColor) // Set the accent color for the tab icons and text
        .modifier(CustomTabBarViewModifier()) // Apply the custom modifier for the tab bar color
    }
}

#Preview {
    MainTabView(
        selectedGoal: "Muscle",
        selectedExperience: "Intermediate",
        selectedPreference: "Weights"
    )
    .environmentObject(FavoritesManager()) // Provide the FavoritesManager environment object
}
