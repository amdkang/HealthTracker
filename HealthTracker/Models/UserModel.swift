//
//  User.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/21/24.
//

import Foundation


struct UserModel : Codable, Identifiable {
    var id: String?
    var firstName : String
    var lastName : String
    var email : String
    var dob : String
    var gender : String
}

//struct UserResults : Codable {
//    let results : [UserModel]
//}
