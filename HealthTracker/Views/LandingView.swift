//
//  ContentView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/15/24.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "cross.circle")
                    .imageScale(.large)
                
                Text("Welcome to HealthTracker")
                    .font(.system(size: 24))
                    .padding(30)
                
                Text("app description")
                    .padding(20)
                
                NavigationLink {
                    SignupView()
                }label : {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color.blue)
                        .cornerRadius(50)
                }
                .padding(20)
                
                NavigationLink {
                    LoginView()
                }label : {
                    Text("Login")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(width: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .cornerRadius(50)
                }
            }
        }
    }
}

#Preview {
    LandingView()
}
