//
//  MedModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/23/24.
//

import Foundation
import FirebaseFirestoreSwift

struct MedModel : Codable, Identifiable {
    @DocumentID var id: String?
    var name : String
    var dosage : String
    var schedule : String
    var prescriber : String
    var notes : String
    var userID : String
//    var conditionID : String
}
