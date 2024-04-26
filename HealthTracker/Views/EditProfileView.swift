//
//  EditProfileView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/23/24.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @State var openHomeView: Bool = false
    
    @Binding var user: UserModel
    
    var body: some View {
        NavigationView {
            Text("Edit Profile")
                .font(.system(size: 30))
                .padding(30)
            
            
            TextField("First Name", text: $user.firstName)
                        .padding(30)
                        .frame(width: 300)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.gray, lineWidth: 1)
                        )
        }
//        .onAppear(perform: getUser)
    }
    
    func getUser() {
        print("getUser ran from ProfileView")
        authViewModel.checkUser()
    }
}

#Preview {
    EditProfileView()
}
