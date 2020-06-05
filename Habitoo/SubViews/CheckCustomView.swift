//
//  CheckCustomView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 04/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct CheckCustomView: View {
    
    @State var habitId: UUID
    @State var selectDate = Date()
    @State var completedHabitFound = false
    @State var showCheckbox = false
    //@State var completedHabitId: UUID
    var collectionUtil = CollectionUtil()
    
    @Environment(\.managedObjectContext) var mocHabitCompleted
    @FetchRequest(entity: TaskCompleted.entity(), sortDescriptors: []) var habitCompleted: FetchedResults<TaskCompleted>
    
    var body: some View {
        HStack {
            ForEach(self.habitCompleted, id: \.self) { data in
                Text("").onAppear() {
                    if data.taskID! == self.habitId && (data.createdDate! == self.collectionUtil.dateFormat(date: self.selectDate)) {
                        //self.stringToDateCompleted(string: self.selectedDate)
                        self.completedHabitFound.toggle()
                        //self.completedHabitId = data.id!
                    }
                    
                }.hidden()
            }
            if completedHabitFound {
                Button(action: {
                    
                }) {
                    Image(systemName: "checkmark.circle").foregroundColor(Color.orange).font(.title)
                        
                }.onTapGesture {
                    //deleteHabit(id: self.completedHabitId)
                    self.completedHabitFound.toggle()
                }
            } else {
                Button(action: {
                    
                }) {
                    Image(systemName: "circle").foregroundColor(Color.orange).font(.title)
                        
                }.onTapGesture {
//                    completedHabit(habitID: self.habitId, completedDate: self.stringToDateCompleted(string: self.selectDate))
                }
            }
        }
    }
    
    private func stringToDateCompleted(string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "d-M-y"
        let date = formatter.date(from: string)!
        return date
    }
}
