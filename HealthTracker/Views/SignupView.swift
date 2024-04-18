//
//  SignupView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/16/24.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    @State var showErr: Bool = false
    @State var errMsg = ""
    @Environment(\.presentationMode) var presentationMode
    
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
                .padding()
                .frame(width: 300)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            SecureField("Re-enter password", text: $passwordCheck)
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
            
            Button(action: signUpClicked) {
                Text("Sign Up")
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

        let passordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passordCheck.evaluate(with: password)
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
            errMsg = "Invalid password syntax. Valid characters: (a-z, A-z, 0-9) and (!@#$%^&*()-_=+`~)"
            return
        }
        else if password != passwordCheck {
            showErr = true
            errMsg = "Passwords do not match"
            return
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    showErr = true
                    errMsg = error.localizedDescription
                    print(error)
                    return
                }
                showErr = false
                errMsg = ""
                self.presentationMode.wrappedValue.dismiss()

            }
        }
    }
}


#Preview {
    SignupView()
}
