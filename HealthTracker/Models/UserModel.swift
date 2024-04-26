//
//  User.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/21/24.
//

import Foundation

struct UserResults : Codable {
    let results : [UserModel]
}

struct UserModel : Codable, Identifiable {
    let id : String
    let firstName : String
    let lastName : String
    let email : String
    let dob : String
    let gender : String
}


//struct CharacterResults : Codable {
//    let results : [CharacterModel]
//}
//
//struct CharacterModel : Codable, Identifiable {
//    let id : Int
//    let name : String
//    let status : String
//    let species : String
//    let gender : String
//    let type : String
//    let image : String
//}
