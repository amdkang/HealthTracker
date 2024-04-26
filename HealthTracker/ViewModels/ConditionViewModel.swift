//
//  ConditionViewModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/23/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class ConditionViewModel : ObservableObject {
    
    @Published var userConditions = [ConditionModel]()
    @Published var newCondition: ConditionModel = ConditionModel(name: "", provider: "", notes: "", userID: "", records: [])
    let db = Firestore.firestore()
    
    
    func getUserConditions(userID: String) {
        self.userConditions.removeAll()
        db.collection("conditions").whereField("userID", isEqualTo: userID).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error fetching matching conditions: \(err)")
            } else {
                for document in querySnapshot!.documents {
                        document.reference.collection("records").getDocuments { (recordsQuerySnapshot, recordsErr) in
                            if let recordsErr = recordsErr {
                                print("Error fetching records: \(recordsErr)")
                            } else {
                                var records = [RecordModel]()
                                for recordDocument in recordsQuerySnapshot!.documents {
                                    do {
                                        records.append(try recordDocument.data(as: RecordModel.self))
                                    } catch {
                                        print(error)
                                    }
                                }
                                do {
                                    var cond = try document.data(as: ConditionModel.self)
                                    cond.records = records
                                    self.userConditions.append(cond)
                                } catch {
                                    print(error)
                                }
                            }
                        }
                }
            }
        }
        self.newCondition = ConditionModel(name: "", provider: "", notes: "", userID: userID, records: [])
    }
 
    
    func saveData(condition: ConditionModel) {
        let conditionData : [String: Any] = [
            "name": condition.name,
            "provider": condition.provider,
            "notes": condition.notes,
            "userID": condition.userID,
        ]
        if let id = condition.id {
            if !condition.name.isEmpty && !condition.userID.isEmpty {
                let docRef = db.collection("conditions").document(id)
                    docRef.updateData(conditionData) { err in
                        if let err = err {
                            print("Error updating condition: \(err)")
                        }
                    }
                }
            } else {
                if !condition.name.isEmpty && !condition.userID.isEmpty {
                    var ref: DocumentReference? = nil
                    ref = db.collection("conditions").addDocument(data: conditionData) { err in
                        if let err = err {
                            print("Error adding condition: \(err)")
                        }
                    }
                }
            }
    }
    
    func addRecord(condition: inout ConditionModel, record: RecordModel) {
        let recordData : [String: Any] = [
            "value": record.value,
            "datetime": Timestamp(date: record.datetime)
        ]
        if !record.value.isEmpty {
            var ref: DocumentReference? = nil
            ref = db.collection("conditions").document(condition.id!).collection("records").addDocument(data: recordData) { err in
                if let err = err {
                    print("Error adding record: ", err)
                }
            }
        }
        condition.records!.append(record)
    }
    
    func deleteRecord(condition: ConditionModel, record: RecordModel) {
        let recordsRef = db.collection("conditions").document(condition.id!).collection("records")
        recordsRef.document(record.id!).delete() { err in
            if let err = err {
                print(err)
            }
        }
    }
    
    func deleteCondition(condition: ConditionModel) {
        for record in condition.records! {
            deleteRecord(condition: condition, record: record)
        }
        db.collection("conditions").document(condition.id!).delete() { err in
            if let err = err {
                print(err)
            }
        }
    }
    
    func resetNewCondition() {
        self.newCondition.name = ""
        self.newCondition.provider = ""
        self.newCondition.notes = ""
        self.newCondition.records = []
    }
}
