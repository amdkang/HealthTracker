//
//  MakeProfileView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/22/24.
//

import SwiftUI
import FirebaseAuth

struct MakeProfileView: View {
    
    @State var email: String
    @State var password: String
    @State var fName = ""
    @State var lName = ""
    @State var dob = Date()
    let genders = ["Male", "Female"]
    @State private var pickedGender = "Male"
    
    @State var showErr: Bool = false
    @State var errMsg = ""
    @State var openHomeView: Bool = false
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Text("Create Profile")
                    .font(.system(size: 30))
                    .padding(30)
                
                Image(pickedGender)
                    .aspectRatio(contentMode: .fit)
                
                TextField("First Name", text: $fName)
                    .padding(30)
                    .frame(width: 300)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                TextField("Last Name", text: $lName)
                    .padding(30)
                    .frame(width: 300)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                HStack(spacing: 60) {
                    Text("Date of Birth:")
                    DatePicker(
                            "Start Date",
                            selection: $dob,
                            displayedComponents: [.date]
                    ) .labelsHidden()
                    
                }
                
                HStack(spacing: 90) {
                    Text("Gender:")
                    Picker("Gender", selection: $pickedGender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                }
                
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
                
                Button(action: enterClicked) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color.blue)
                        .cornerRadius(50)
                }
                .padding(10)
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: date)
    }
    
    func enterClicked() {
        if fName.isEmpty || lName.isEmpty {
            showErr = true
            errMsg = "Please fill out all above fields"
            return
        } else {
            authViewModel.signUpUser(email: email, password: password, fName: fName, lName: lName, dob: formatDate(dob), gender: pickedGender) { success, error in
                if success {
                    showErr = false
                    errMsg = ""
                    openHomeView = true
                } else if (error != nil) {
                    showErr = true
                    errMsg = "Error while creating user. Please try again"
                }
                
            }

        }
    }
}

//<a href="https://www.flaticon.com/free-icons/people" title="people icons">People icons created by Prosymbols Premium - Flaticon</a>
//<a href="https://www.flaticon.com/free-icons/female" title="female icons">Female icons created by Prosymbols Premium - Flaticon</a>
