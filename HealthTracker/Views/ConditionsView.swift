//
//  ConditionsView.swift
//  HealthTracker
//
//  Created by Amenda Kang on 4/16/24.
//

import SwiftUI

struct ConditionsView: View {
    @Binding var user: UserModel?
    @ObservedObject var condViewModel = ConditionViewModel()
    
    var body: some View {
        if let user = user, let userID = user.id {
             NavigationView {
                 VStack(alignment: .leading) {
                     Text("Your Conditions")
                          .font(.title)
                          .fontWeight(.bold)
                          .padding(20)
                     
                     List {
                         ForEach($condViewModel.userConditions) { $cond in
                             NavigationLink {
                                 ConditionDetailView(condition: $cond)
                             } label: {
                                 Text(cond.name)
                             }
                         }
                         .onDelete { indexSet in
                             indexSet.forEach { index in
                                 condViewModel.deleteCondition(condition: condViewModel.userConditions[index])
                             }
                         }
                         
                         Section {
                            NavigationLink {
                                ConditionDetailView(condition: $condViewModel.newCondition)
                            } label : {
                                Text("Add Condition")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 15))
                            }
                        }
                     }
                 }
                 
            }
             .onAppear { condViewModel.getUserConditions(userID: userID) }
             .refreshable { condViewModel.getUserConditions(userID: userID) }
        }
    }
}
