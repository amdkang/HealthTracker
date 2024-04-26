//
//  ConditionModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/23/24.
//

import Foundation
import FirebaseFirestoreSwift

struct ConditionModel : Codable, Identifiable {
    @DocumentID var id: String?
    var name : String
    var provider : String
    var notes : String
    var userID : String
    var records: [RecordModel]?
}
