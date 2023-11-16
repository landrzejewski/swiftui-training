//
//  GoodWeatherApp.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI
import Factory

@main
struct GoodWeatherApp: App {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ForecastRouterView()
                    .environmentObject(ForecastRouter())
                    .tabItem {
                        Image(systemName: "sun.max.fill")
                        Text("Forecast")
                    }
                FoodListView(viewModel: Container.shared.foodListViewModel())
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Food")
                    }
                ProfieView(viewModel: Container.shared.profileViewModel())
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .accentColor(.activeColor)
        }
    }
    
}
