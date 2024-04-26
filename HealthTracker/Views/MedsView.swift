//
//  MedsView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/22/24.
//

import SwiftUI

struct MedsView: View {
    @Binding var user: UserModel?
    @ObservedObject var medViewModel = MedViewModel()
    
    var body: some View {
        if let user = user, let userID = user.id {
             NavigationView {
                 VStack(alignment: .leading) {
                     Text("Your Medications")
                          .font(.title)
                          .fontWeight(.bold)
                          .padding(20)
                     List {
                         ForEach($medViewModel.userMeds) { $med in
                             NavigationLink {
                                 MedDetailView(med: $med)
                             } label: {
                                 Text("\(med.name) (\(med.dosage))")
                             }
                         }
                         .onDelete { indexSet in
                             indexSet.forEach { index in
                                 medViewModel.deleteMed(med: medViewModel.userMeds[index])
                             }
                         }
                         
                         Section {
                            NavigationLink {
                                MedDetailView(med: $medViewModel.newMed)
                            } label : {
                                Text("Add Medication")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 15))
                            }
                        }
                     }
                 }
            }
             .navigationTitle("Your Medications")
             .onAppear { medViewModel.getUserMeds(userID: userID) }
             .refreshable { medViewModel.getUserMeds(userID: userID) }
        }
    }
}
