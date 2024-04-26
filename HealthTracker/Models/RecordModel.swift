//
//  RecordModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/24/24.
//

import Foundation
import FirebaseFirestoreSwift

struct RecordModel : Codable, Identifiable {
    @DocumentID var id: String?
    var value: String
    var datetime: Date
}
