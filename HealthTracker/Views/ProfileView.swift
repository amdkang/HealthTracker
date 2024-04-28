//
//  ProfileView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/22/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var user: UserModel?
    @ObservedObject var authViewModel = AuthViewModel()
    @State var openLandingView: Bool = false
    
    var body: some View {
        if let user = user {
            ZStack {
                VStack {
                    HStack() {
                        Text("HealthTracker")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(20)
                    
                    Spacer()

                    VStack(alignment: .center, spacing: 20) {
                        Text("Your Profile")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Image(uiImage: UIImage(named: user.gender)!)
                            .resizable()
                            .frame(width:100, height: 100, alignment: .center)
                                
                        Text("\(user.firstName) \(user.lastName)")
                            .font(.title)
                            
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                                
                        VStack(spacing: 20) {
                            Spacer().frame(height: 30)
                            HStack {
                                Text("Date of Birth: ")
                                Text(user.dob)
                            }
                            HStack {
                                Text("Gender: ")
                                Text(user.gender)
                            }
                        }
                        NavigationLink(
                            destination: LandingView(),
                            isActive: $openLandingView,
                            label: { EmptyView() }
                        )
                        
                        Button(action: {
                            authViewModel.stopAuth()
                            openLandingView = true})
                        {
                            Text("Log Out")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300)
                                .background(Color.blue)
                                .cornerRadius(50)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
        }
    }
}
