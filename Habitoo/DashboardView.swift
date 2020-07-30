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
    var listOfHabits = [Any]()
    var listOfTasks = [Any]()
    private var collectionUtil = CollectionUtil()
    var weekDay = ["S","M","T","W","T","F","S"]
    
    var arrayHabitName = [String]()
    var arrayHabitID = [UUID]()
    var arrayHabitWeekDays = [String]()
    
    var arrayTaskName = [String]()
    var arrayTaskID = [UUID]()
    var arrayTaskWeekDays = [String]()
    
    @ObservedObject var completeDatabaseUtil = CompleteDatabaseUtil()
    
    //tasks completed record
    var listOfTasksComplete = [Any]()
    //private var arrayTaskNameComplete = [String]()
    var arrayTaskIDComplete = [UUID]()
    var arrayTaskUUIDComplete = [UUID]()
    var arrayTaskDateComplete = [Date]()
    
    var completedTaskFound = false
    var isHabitCompleteBtn = false
    var listOfHabitsComplete = [Any]()
    var arrayHabitUUIDComplete = [UUID]()
    @State var isDetailShown = false
    @State var isDetailHabitShown = false
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        presentDay = dateUtil.getCurrentDay()
        currentWeekDays = dateUtil.currentWeekDays()
        //fetch record from database
        listOfHabitsComplete = completeDatabaseUtil.fetchCompletedHabits()
        arrayHabitUUIDComplete = listOfHabitsComplete[1] as! [UUID]
        //print("\(self.listOfHabitsComplete)")
        //fetch habits list from database
        listOfHabits = database.fetchHabitsFromDatabase()
        //seprate habit name from array
        arrayHabitName = listOfHabits[0] as! [String]
        //seprate habit id from array
        arrayHabitID = listOfHabits[1] as! [UUID]
        //seprate habit id from array
        arrayHabitWeekDays = listOfHabits[2] as! [String]
        //fetch tasks list from database
        listOfTasks = database.fetchTasksFromDatabase()
        arrayTaskName = listOfTasks[0] as! [String]
        arrayTaskID = listOfTasks[1] as! [UUID]
        arrayTaskWeekDays = listOfTasks[2] as! [String]
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
                        if arrayHabitID.count > 0 {
                            ForEach(0..<arrayHabitName.count, id: \.self) { index in
                                VStack(alignment: .leading) {
//                                    NavigationLink(destination: HabitDetailView(uuid: self.arrayHabitID[index],category: "habit")) {
                                        Text("\(self.arrayHabitName[index])").padding()
                                            .font(Font.headline.weight(.semibold))
                                            .foregroundColor(.orange)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 18))
                                            .onTapGesture {
                                                self.isDetailHabitShown.toggle()
                                            }
                                            .sheet(isPresented: self.$isDetailHabitShown) {
                                                HabitDetailView(uuid: self.arrayHabitID[index],category: "habit")
                                            }
                                        
                                    //}.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 18))
                                    HStack {
                                        ForEach(0..<7) { i in
                                            HStack {
                                                
                                                if self.currentWeekDays[i] == self.presentDay {
                                                    HabitCompleteCheckBoxView(habitID: self.arrayHabitID[index],habitName: self.arrayHabitName[index], currentIndex: i, weekDays: self.arrayHabitWeekDays[index])
                                                }else {
                                                    DashboardHabitHistory(habitID: self.arrayHabitID[index],currentDay: self.currentWeekDays[i], currentIndex: i, weekDays: self.arrayHabitWeekDays[index])
                                                }
                                                
                                            }
                                        }
                                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                }.background(self.colorUtil.getlightGrayColor())
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                
                            }//.onDelete(perform: deleteHabit)
                            .onDelete { (indexSet) in
                                for offset in indexSet {
                                    //self.arrayHabitName.remove(at: offset)
                                }
                            }
                        } else {
                            Text("No record found")
                        }
                        
                        Text("TASKS FOR TODAY").font(Font.subheadline.weight(.semibold))
                        
                        if arrayTaskName.count > 0 {
                            ForEach(0..<arrayTaskName.count, id: \.self) { index in
                                HStack {
                                    Text("\(self.arrayTaskName[index])")
                                        .font(Font.headline.weight(.semibold))
                                    .onTapGesture {
                                        self.isDetailShown.toggle()
                                    }
                                    .sheet(isPresented: self.$isDetailShown) {
                                        HabitDetailView(uuid: self.arrayTaskID[index], category: "task")
                                    }
//                                    NavigationLink(destination: HabitDetailView(uuid: self.arrayTaskID[index], category: "task")) {
//                                        EmptyView()
//                                    }.buttonStyle(PlainButtonStyle())
                                    Spacer()
                                    TasksCheckBoxView(taskID: self.arrayTaskID[index], weekDays: self.arrayTaskWeekDays[index])
                                }
                                
                                
                            }.onDelete(perform: deleteTask)
                        } else {
                            Text("No record found")
                        }
                        
                    }
                    
                    
                    
                }
                Spacer()
            }.navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
    
    private func deleteHabit(with indexSet: IndexSet) {
        //indexSet.forEach { islands.remove(at: $0) }
        //for offset in indexSet {
            //let habit = self.habitDb[offset]
            //self.database.deleteHabit(uuid: self.arrayHabitID[offset])
        //}
        //arrayHabitName.remove(atOffsets: indexSet)
    }
    
    private func deleteTask(with indexSet: IndexSet) {
        
    }
}

