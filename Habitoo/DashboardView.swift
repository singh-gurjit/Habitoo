//
//  DashboardView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 13/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    
    private var date = Date()
    var dateUtil = DateUtil()
    var colorUtil = ColorUtil()
    var presentDay: String
    var currentWeekDays = [String]()
    @State var presentDateIndex = 0
    private var database = DatabaseUtil()
    private var listOfHabits = [Any]()
    private var listOfTasks = [Any]()
    private var collectionUtil = CollectionUtil()
    var weekDay = ["S","M","T","W","T","F","S"]
    
    private var arrayHabitName = [String]()
    private var arrayHabitID = [UUID]()
    
    private var arrayTaskName = [String]()
    private var arrayTaskID = [UUID]()
    
    @ObservedObject var completeDatabaseUtil = CompleteDatabaseUtil()
    
    //tasks completed record
    private var listOfTasksComplete = [Any]()
    //private var arrayTaskNameComplete = [String]()
    private var arrayTaskIDComplete = [UUID]()
    private var arrayTaskUUIDComplete = [UUID]()
    private var arrayTaskDateComplete = [Date]()
    
    @State var completedTaskFound = false
    @State var isHabitCompleteBtn = false
    @State var listOfHabitsComplete = [Any]()
    @State var arrayHabitUUIDComplete = [UUID]()
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        presentDay = dateUtil.getCurrentDay()
        currentWeekDays = dateUtil.currentWeekDays()
        //fetch habits list from database
        listOfHabits = database.fetchHabitsFromDatabase()
        //seprate habit name from array
        arrayHabitName = listOfHabits[0] as! [String]
        //sepeate habit id from array
        arrayHabitID = listOfHabits[1] as! [UUID]
        //fetch tasks list from database
        listOfTasks = database.fetchTasksFromDatabase()
        arrayTaskName = listOfTasks[0] as! [String]
        arrayTaskID = listOfTasks[1] as! [UUID]
        //fetch completes tasks list
        listOfTasksComplete = completeDatabaseUtil.fetchCompletedTasks()
        //fetch task name completed
        //arrayTaskNameComplete = listOfTasksComplete[0] as! [String]
        arrayTaskIDComplete = listOfTasksComplete[0] as! [UUID]
        arrayTaskUUIDComplete = listOfTasksComplete[1] as! [UUID]
        arrayTaskDateComplete = listOfTasksComplete[2] as! [Date]
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing:10) {
                HStack {
                    ForEach(0..<7) { index in
                        Spacer()
                        //check current date and highlight it
                        if self.currentWeekDays[index] == self.presentDay {
                            VStack {
                                Text("\(self.currentWeekDays[index])")
                                    .onAppear() {
                                        self.presentDateIndex = index
                                }
                                Text("\(self.weekDay[index])")
                            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                
                                .background(Color.orange)
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                        } else {
                            VStack {
                                Text("\(self.currentWeekDays[index])")
                                    .foregroundColor(Color.orange)
                                Text("\(self.weekDay[index])")
                                    .foregroundColor(Color.gray)
                            }
                            
                        }
                        Spacer()
                    }
                }
                
                VStack {
                    List {
                        Text("HABITS FOR TODAY").font(Font.subheadline.weight(.semibold))
                            .onAppear() {
                                //fetch record from database
                                self.listOfHabitsComplete = self.completeDatabaseUtil.fetchCompletedHabits()
                                self.arrayHabitUUIDComplete = self.listOfHabitsComplete[1] as! [UUID]
                                print("\(self.listOfHabitsComplete)")
                        }
                        ForEach(0..<arrayHabitName.count, id: \.self) { index in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: HabitDetailView(uuid: self.arrayHabitID[index])) {
                                    Text("\(self.arrayHabitName[index])").padding()
                                        .font(Font.headline.weight(.semibold))
                                        .foregroundColor(.orange)
                                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 18))
                                HStack {
                                    ForEach(0..<7) { data in
                                        if data == self.presentDateIndex {
                                            if self.isHabitCompleteBtn {
                                                
                                                Image(systemName: "checkmark.circle")
                                                    .font(.title)
                                                    .frame(minWidth: 0, maxWidth: .infinity)
                                                    .foregroundColor(.orange)
                                                    .onTapGesture {
                                                        //change button state
                                                        self.isHabitCompleteBtn.toggle()
                                                        //delete record from database
                                                        self.completeDatabaseUtil.deleteHabitCompleted(id: self.arrayHabitID[index])
                                                }.onAppear() {
                                                    
                                                }
                                            } else {
                                                Image(systemName: "circle")
                                                    .font(.title)
                                                    .frame(minWidth: 0, maxWidth: .infinity)
                                                    .foregroundColor(.orange)
                                                    .onAppear() {
                                                        
                                                    }
                                                    .onTapGesture {
                                                        //change button state
                                                        self.isHabitCompleteBtn.toggle()
                                                        //save data to database
                                                        self.completeDatabaseUtil.insertCompletedHabit(habitName: self.arrayHabitName[index], uuid: self.arrayHabitID[index], cDate: self.collectionUtil.dateFormat(date: self.date))
                                                }}
                                        } else {
                                            Image(systemName: "circle")
                                                .font(.headline)
                                                .frame(minWidth: 0, maxWidth: .infinity)
                                        }
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            }.background(self.colorUtil.getlightGrayColor())
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                        }
                        Text("You only 1 habit to do today!")
                            .foregroundColor(Color.gray).font(.subheadline)
                        
                        Text("TASKS FOR TODAY").font(Font.subheadline.weight(.semibold))
                        
                        ForEach(0..<arrayTaskName.count, id: \.self) { index in
                            HStack {
                                Text("\(self.arrayTaskName[index])")
                                    .font(Font.headline.weight(.semibold))
                                NavigationLink(destination: HabitDetailView(uuid: self.arrayTaskID[index])) {
                                    EmptyView()
                                }.buttonStyle(PlainButtonStyle())
                                Spacer()
                                TasksCheckBoxView(taskID: self.arrayTaskID[index])
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
            }.navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

