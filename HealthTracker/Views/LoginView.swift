//
//  LoginView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/16/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var showErr: Bool = false
    @State var errMsg = ""
    @State var openHomeView: Bool = false
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Text("Log In")
                    .font(.system(size: 30))
                    .padding(30)
                
                TextField("Email Address", text: $email)
                    .padding(30)
                    .frame(width: 300)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                SecureField("Password", text: $password)
                    .textContentType(.oneTimeCode)
                    .padding(30)
                    .frame(width: 300)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                if showErr {
                    Text(errMsg)
                        .foregroundColor(Color.red)
                        .padding(10)
                }
                
                NavigationLink(
                    destination: HomeView(),
                    isActive: $openHomeView,
                    label: { EmptyView() }
                )
                
                Button(action: loginClicked) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color.blue)
                        .cornerRadius(50)
                }
                .padding(30)
            }
        }
    }
    
    func loginClicked() {
        if email.isEmpty || password.isEmpty {
            showErr = true
            errMsg = "Please fill out all above fields"
            return
        } else {
            
            authViewModel.loginUser(email: email, password: password) { success, error in
                if success {
                    showErr = false
                    errMsg = ""
                    openHomeView = true
                } else if (error != nil) {
                    showErr = true
                    errMsg = "Error logging in. Please try again"
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
