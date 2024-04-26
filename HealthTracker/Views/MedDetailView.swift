//
//  MedDetailView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/24/24.
//

import SwiftUI

struct MedDetailView: View {
    
    @Binding var med : MedModel
    @ObservedObject var medViewModel = MedViewModel()
    let schedule = ["AM", "PM", "none"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Medication Name", text: $med.name)
                .font(.system(size: 25))
                .fontWeight(.bold)
            
            HStack {
                Text("Dosage: ")
                TextField("Amount/Unit", text: $med.dosage)
            }
            
            HStack {
                Text("Schedule:")
                Picker("Schedule", selection: $med.schedule) {
                    ForEach(schedule, id: \.self) { sched in
                        Text(sched)
                    }
                }
            }
            
            HStack {
                Text("Prescribed by: ")
                TextField("Provider Name", text: $med.prescriber)
            }
            
            VStack(alignment: .leading) {
                Text("Notes: ")
                TextEditor(text: $med.notes)
                    .font(.system(size: 20))
                    .frame(height: 150)
                    .border(Color.gray.opacity(0.1), width: 1)
            }
    
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    medViewModel.saveData(med: med)
                    medViewModel.resetNewMed()
                } label: {
                    Text("Save")
                }
            }
        }
        Spacer()
    }
}
