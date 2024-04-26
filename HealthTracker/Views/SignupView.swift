//
//  SignupView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/16/24.
//

import SwiftUI

struct SignupView: View {
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    @State var showErr: Bool = false
    @State var errMsg = ""
    @State var openMakeProfileView: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.system(size: 30))
                .padding(30)
            
            TextField("Email Address", text: $email)
                .padding()
                .frame(width: 300)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            SecureField("Password", text: $password)
                .textContentType(.oneTimeCode)
                .padding()
                .frame(width: 300)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            
            SecureField("Re-enter password", text: $passwordCheck)
                .textContentType(.oneTimeCode)
                .padding()
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
                destination: MakeProfileView(email: email, password: password),
                isActive: $openMakeProfileView,
                label: { EmptyView() }
            )

            Button(action: signUpClicked) {
                Text("Next")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color.blue)
                    .cornerRadius(50)
            }
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailCheck.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = #"^[a-zA-Z0-9!@#$%^&*()-_=+`~]+$"#
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isValidLength = password.count >= 6
        return passwordCheck.evaluate(with: password) && isValidLength
    }
    
    func signUpClicked() {
        if email.isEmpty || password.isEmpty || passwordCheck.isEmpty {
            showErr = true
            errMsg = "Please fill out all above fields"
            return
        }
        else if !validateEmail(email) {
            showErr = true
            errMsg = "Invalid email address"
            return
        }
        else if !validatePassword(password) {
            showErr = true
            errMsg = "Invalid password. Must be atleast 6 characters long. Valid characters: (a-z, A-z, 0-9) and (!@#$%^&*()-_=+`~)"
            return
        }
        else if password != passwordCheck {
            showErr = true
            errMsg = "Passwords do not match"
            return
        } else {
            showErr = false
            errMsg = ""
            openMakeProfileView = true
    
        }
    }
}

#Preview {
    SignupView()
}
