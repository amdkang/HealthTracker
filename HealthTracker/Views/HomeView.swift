//
//  HomeView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/22/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        VStack {
            TabView {
                if let user = authViewModel.currentUser {
                    ProfileView(user: $authViewModel.currentUser)
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                    
                    
                    ConditionsView(user: $authViewModel.currentUser)
                        .tabItem {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            Text("Conditions")
                        }
                    
                    MedsView(user: $authViewModel.currentUser)
                        .tabItem {
                            Image(systemName: "pill.fill")
                            Text("Meds")
                        }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            if !hasAppeared {
                authViewModel.checkUser()
                hasAppeared = true
            }
                
        }
    }
}

#Preview {
    HomeView()
}
