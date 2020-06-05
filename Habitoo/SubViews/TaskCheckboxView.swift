//
//  TaskCheckboxView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 30/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI
import CoreData

struct TaskCheckboxView: View {
    
    @State var taskID: UUID
    private var completeDatabaseUtil = CompleteDatabaseUtil()
    private var collectionUtil = CollectionUtil()
    var date = Date()
    //tasks completed record
    @State var listOfTasksComplete = [Any]()
    @State var arrayTaskNameComplete = [String]()
    @State var arrayTaskIDComplete = [UUID]()
    @State var arrayTaskUUIDComplete = [UUID]()
    @State var arrayTaskDateComplete = [Date]()
    @State var completedTaskFound = false
    
    
    var body: some View {
        VStack{
        Text("").onAppear() {
            self.listOfTasksComplete = self.completeDatabaseUtil.fetchCompletedTasks()
            //fetch task name completed
            self.arrayTaskNameComplete = self.listOfTasksComplete[0] as! [String]
            self.arrayTaskIDComplete = self.listOfTasksComplete[1] as! [UUID]
            self.arrayTaskUUIDComplete = self.listOfTasksComplete[2] as! [UUID]
            self.arrayTaskDateComplete = self.listOfTasksComplete[3] as! [Date]
        }
        HStack {
        //check if task is completed or not
        ForEach(0..<self.arrayTaskNameComplete.count) { index in
            Text("").onAppear() {
                print("\(self.listOfTasksComplete)")
                print("\(String(describing: self.taskID))")
                if self.taskID == self.arrayTaskUUIDComplete[index] && self.collectionUtil.dateFormat(date: self.arrayTaskDateComplete[index]) == self.collectionUtil.dateFormat(date: self.date) {
                    
                    self.completedTaskFound.toggle()
                    
                }
            }
        }
            if self.completedTaskFound {
                Image(systemName: "stop.fill")
                    .foregroundColor(Color.orange)
                    .font(Font.title.weight(.medium))
                    .padding(5)
                    .onTapGesture {
//                        let id: UUID = self.arrayTaskID[index]
//                        let name: String = self.arrayTaskName[index]
//                        self.completeDatabaseUtil.insertCompletedTask(taskName: name, uuid: id, cDate: self.collectionUtil.dateFormat(date: self.date))
                        print("\(String(describing: self.taskID))")
                }
            } else {
                Image(systemName: "stop")
                    .foregroundColor(Color.orange)
                    .font(Font.title.weight(.medium))
                    .padding(5)
                    .onTapGesture {
//                        let id: UUID = self.arrayTaskID[index]
//                        let name: String = self.arrayTaskName[index]
//                        self.completeDatabaseUtil.insertCompletedTask(taskName: name, uuid: id, cDate: self.collectionUtil.dateFormat(date: self.date))
                        print("\(String(describing: self.taskID))")
                }
            }
        }
    }
    }
}
