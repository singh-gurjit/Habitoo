//
//  TasksCheckBoxView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 30/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct TasksCheckBoxView: View {
    @ObservedObject var completeDatabaseUtil = CompleteDatabaseUtil()
    var collectionUtil = CollectionUtil()
    var date = Date()
    //tasks completed record
    @State var listOfTasksComplete = [Any]()
    @State var arrayTaskIDComplete = [UUID]()
    @State var arrayTaskUUIDComplete = [UUID]()
    @State var arrayTaskDateComplete = [Date]()
    @State var completedTaskFound = false
    @State var taskID: UUID?
    @State var completedTaskIndex = 0
    @State var completedTaskCount = 0
    @State var arrayCompleted = [Any]()
    @State var checkBoxImage = "stop"
    @State var currentIndex: Int = 0
    @State var weekDays: String
    @State var arrayWeekDays = [String]()
    @State var currentWeekDays = [String]()
    var dateUtil = DateUtil()
    @State var presentDay: String = ""
    @State var currentDayIndex = 0
    
    var body: some View {
        VStack {
            Text("").onAppear() {
                self.listOfTasksComplete = self.completeDatabaseUtil.fetchCompletedTasks()
                //fetch task name completed
                self.arrayTaskIDComplete = self.listOfTasksComplete[0] as! [UUID]
                self.arrayTaskUUIDComplete = self.listOfTasksComplete[1] as! [UUID]
                self.arrayTaskDateComplete = self.listOfTasksComplete[2] as! [Date]
                self.completedTaskCount = self.arrayTaskIDComplete.count
                self.arrayWeekDays = self.collectionUtil.stringToArray(string: self.weekDays)
                self.presentDay = self.dateUtil.getCurrentDay()
                self.currentWeekDays = self.dateUtil.currentWeekDays()
                //print("\(self.arrayWeekDays), \(self.currentWeekDays), \(self.presentDay)")
                self.currentDayIndex = self.currentWeekDays.firstIndex(of: self.presentDay)!
                //print("\(self.currentDayIndex)")
            }
            
            HStack(alignment:.center) {
                
                //check if task is completed or not
                ForEach(0..<self.arrayTaskIDComplete.count, id: \.self) { index in
                    
                    Text("").onAppear() {
                        if self.taskID == self.arrayTaskUUIDComplete[index] && self.collectionUtil.dateFormat(date: self.arrayTaskDateComplete[index]) == self.collectionUtil.dateFormat(date: self.date) {
                            //check if task already found or not
                            if self.completedTaskFound == false {
                                self.completedTaskFound.toggle()
                            }
                            self.completedTaskIndex = index
                        }
                    }.hidden()
                }
                //if completed task found
                if self.arrayWeekDays.contains("\(currentDayIndex)") {
                if self.completedTaskFound {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(Color.orange)
                        .font(Font.title.weight(.medium))
                        
                        .onTapGesture {
                            self.completeDatabaseUtil.deleteTaskCompleted(id: self.arrayTaskIDComplete[self.completedTaskIndex])
                            self.completedTaskFound.toggle()
                    }
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(Color.orange)
                        .font(Font.title.weight(.medium))
                        
                        .onTapGesture {
                            self.completeDatabaseUtil.insertCompletedTask(uuid: self.taskID!, cDate: self.collectionUtil.dateFormat(date: self.date))
                            self.completedTaskFound.toggle()
                    }
                }
                } else {
                    Image(systemName: "minus")
                    .foregroundColor(Color.gray)
                    .font(Font.title.weight(.medium))
                }
            }
        }
        
    }
    
    func isTaskCompleted(uuid: UUID, cDate: Date) -> Bool {
        
        if self.taskID == uuid && cDate == self.collectionUtil.dateFormat(date: self.date) {
            return true
        } else {
            return false
        }
    }
}
