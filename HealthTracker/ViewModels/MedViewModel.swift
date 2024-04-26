//
//  MedViewModel.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/23/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class MedViewModel : ObservableObject {
    
    @Published var userMeds = [MedModel]()
    @Published var newMed: MedModel = MedModel(name: "", dosage: "", schedule: "AM", prescriber: "", notes: "", userID: "")
    let db = Firestore.firestore()
    
    func getUserMeds(userID: String) {
        self.userMeds.removeAll()
        db.collection("meds").whereField("userID", isEqualTo: userID).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error fetching matching meds: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        self.userMeds.append(try document.data(as: MedModel.self))
                    } catch {
                        print(error)
                    }
                }
            }
        }
        self.newMed = MedModel(name: "", dosage: "", schedule: "AM", prescriber: "", notes: "", userID: userID)
    }
    
    
    func saveData(med: MedModel) {
        let medData : [String: Any] = [
            "name": med.name,
            "dosage": med.dosage,
            "schedule": med.schedule,
            "prescriber": med.prescriber,
            "notes": med.notes,
            "userID": med.userID
        ]
        if let id = med.id {
            if !med.name.isEmpty && !med.userID.isEmpty {
                let docRef = db.collection("meds").document(id)
                    docRef.updateData(medData) { err in
                        if let err = err {
                            print("Error updating med: \(err)")
                        }
                    }
                }
            } else {
                if !med.name.isEmpty && !med.userID.isEmpty {
                    var ref: DocumentReference? = nil
                    ref = db.collection("meds").addDocument(data: medData) { err in
                        if let err = err {
                            print("Error adding med: \(err)")
                        }
                    }
                }
            }
    }
    
    func deleteMed(med: MedModel) {
        db.collection("meds").document(med.id!).delete() { err in
            if let err = err {
                print(err)
            }
        }
    }
    
    func resetNewMed() {
        self.newMed.name = ""
        self.newMed.dosage = ""
        self.newMed.schedule = "AM"
        self.newMed.prescriber = ""
        self.newMed.notes = ""
    }
}
