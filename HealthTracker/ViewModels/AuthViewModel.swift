//
//  AuthViewModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/22/24.
//

import Foundation
import FirebaseAuth

class AuthViewModel : ObservableObject {
    @Published var currentUser: UserModel?
    var userViewModel = UserViewModel()
    var handle: AuthStateDidChangeListenerHandle?

    func checkUser() {
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    self.userViewModel.getUserByID(userID: user.uid) { matchingUser, error in
                        if (matchingUser != nil) {
                            self.currentUser = matchingUser
                        }
                    }
                } else {
                    self.currentUser = nil
                }
            }
    }
    
    
    func stopAuth() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
            self.currentUser = nil
            self.handle = nil
        }
    }
    
    func signUpUser(email: String, password: String, fName: String, lName: String, dob: String, gender: String, _ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
            }
            let newUser = UserModel(id: (authResult?.user.uid)!, firstName: fName, lastName: lName, email: email, dob: dob, gender: gender)
            self.userViewModel.addUser(user: newUser)
            completion(true, nil)
        }
    }
    
    
    func loginUser(email: String, password: String, _ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
        }
            completion(true, nil)
        }
    }
}
