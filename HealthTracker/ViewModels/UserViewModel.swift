//
//  UserViewModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/22/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class UserViewModel : ObservableObject {
    @Published var users = [UserModel]()
    let db = Firestore.firestore()
    
    func getUserByID(userID: String, _ completion: @escaping (_ matchingUser: UserModel?, _ error: Error?) -> Void) {
        db.collection("users").document(userID).getDocument { (documentSnapshot, err) in
            if let err = err {
                print("Error fetching user: \(err)")
                completion(nil, err)
            } else {
                
                do {
                    var user = try documentSnapshot!.data(as: UserModel.self)
                    user.id = documentSnapshot!.documentID
                    completion(user, nil)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func addUser(user: UserModel) {
        if !user.firstName.isEmpty || !user.lastName.isEmpty {
            let userData : [String: Any] = [
                "firstName": user.firstName,
                "lastName": user.lastName,
                "email": user.email,
                "dob": user.dob,
                "gender": user.gender
            ]

            db.collection("users").document(user.id!).setData(userData) { err in
                if let err = err {
                    print("Error adding user to db: \(err)")
                }
            }
        }
    }
}


