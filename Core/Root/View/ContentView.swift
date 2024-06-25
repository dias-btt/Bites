//
//  ContentView.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    @State private var shouldShowOnboarding = false
    
    init() {
        // Check if onboarding has been shown previously
        let hasShownOnboarding = UserDefaults.standard.bool(forKey: "hasShownOnboarding")
        shouldShowOnboarding = !hasShownOnboarding
        print("show onboarding? \(shouldShowOnboarding)")
        
        // Set the flag after checking
        if !hasShownOnboarding {
            UserDefaults.standard.set(true, forKey: "hasShownOnboarding")
        }
    }
    
    var body: some View {
        Group {
            if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
}

