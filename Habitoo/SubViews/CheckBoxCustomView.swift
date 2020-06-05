//
//  CheckBoxCustomView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 02/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct CheckBoxCustomView: View {

@State var taskId: UUID
@State var selectDate: Date
@State var completedTaskFound = false
@State var showCheckbox = false
@State var completedTaskId: UUID
var collectionUtil = CollectionUtil()

@Environment(\.managedObjectContext) var mocHabitCompleted
@FetchRequest(entity: TaskCompleted.entity(), sortDescriptors: []) var taskCompleted: FetchedResults<TaskCompleted>

var body: some View {
    HStack {
        ForEach(self.taskCompleted, id: \.self) { data in
            Text("").onAppear() {
                if data.taskID! == self.taskId && (data.createdDate! == self.collectionUtil.dateFormat(date: self.selectDate)) {
                    //self.stringToDateCompleted(string: self.selectedDate)
                    self.completedTaskFound.toggle()
                    self.completedTaskId = data.id!
                }
                
            }.hidden()
        }
        if completedTaskFound {
            Button(action: {
                
            }) {
                Image(systemName: "checkmark.circle").foregroundColor(Color.white).font(.title)
            }.onTapGesture {
                
            }
        } else {
            Button(action: {
                
            }) {
                Image(systemName: "circle").foregroundColor(Color.white).font(.title)
            }.onTapGesture {
                
            }
        }
    }
    }
}
