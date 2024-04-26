//
//  ConditionDetailView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/23/24.
//

import SwiftUI

struct ConditionDetailView: View {
    @Binding var condition : ConditionModel
    @ObservedObject var condViewModel = ConditionViewModel()
    @State var recordButton = "Add Record"
    @State var addRecord: Bool = true
    @State var recordVal = ""
    @State var selectedDate = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Condition Name", text: $condition.name)
                .font(.system(size: 25))
                .fontWeight(.bold)
            
            HStack {
                Text("Managed By: ")
                TextField("Provider Name", text: $condition.provider)
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading) {
                Text("Notes: ")
                TextEditor(text: $condition.notes)
                    .font(.system(size: 20))
                    .frame(height: 150)
                    .border(Color.gray.opacity(0.1), width: 1)
            }
            
            if condition.id != nil {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Records: ")
                        Spacer()
                        Button { toggleRecords() }
                    label: { Text(recordButton) }
                    }
                    
                    if !addRecord {
                        HStack {
                            Text("Value: ")
                            TextField("", text: $recordVal)
                                .border(Color.gray.opacity(0.1), width: 1)
                        }
                        .padding()
                        
                        DatePicker("Date/Time", selection: $selectedDate, in: ...Date())
                            .padding()
                    }
                    
                    if let records = condition.records {
                        List {
                            Section( header:
                                        HStack {
                                Text("Value")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .font(.headline)
                                Spacer()
                                Text("DateTime")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .font(.headline)
                            })
                            {
                                ForEach(records) { record in
                                    HStack {
                                        Text(record.value)
                                            .frame(width: 80, alignment: .leading)
                                        Spacer()
                                        Text(formatDate(record.datetime))
                                            .frame(width: 120, alignment: .leading)
                                    }.padding()
                                    
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        condViewModel.deleteRecord(condition: condition, record: records[index])
                                    }
                                }
                            }
                        }
                    }
                    
                }.padding(.top, 20)
            }
        }.padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    condViewModel.saveData(condition: condition)
                    condViewModel.resetNewCondition()
                } label: {
                    Text("Save")
                }
            }
        }
        Spacer()
    }
    
    func formatDate(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    func toggleRecords() {
        if (addRecord) {
            addRecord = false
            recordButton = "Save Record"
        } else {
            condViewModel.addRecord(condition: &condition, record: RecordModel(value: recordVal, datetime: selectedDate))
            addRecord = true
            recordButton = "Add Record"
        }
    }
}
