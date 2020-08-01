//
//  Dash.swift
//  Habitoo
//
//  Created by Gurjit Singh on 30/07/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct Dash: View {
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
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Habits.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Habits.createdDate, ascending: false)], predicate: NSPredicate(format: "category == %@", "habit")) var habitDb: FetchedResults<Habits>
    
    @Environment(\.managedObjectContext) var mocTask
    @FetchRequest(entity: Habits.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Habits.createdDate, ascending: false)], predicate: NSPredicate(format: "category == %@", "task")) var habitDbTasks: FetchedResults<Habits>
    
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
                        
                        ForEach(habitDb, id: \.self) { item in
                            
                            VStack(alignment: .leading) {
                                Text("\(item.name!)").font(Font.headline.weight(.semibold))
                                    .foregroundColor(.orange)
                                    //.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 18))
                                    .padding()
                                
                                HStack {
                                    ForEach(0..<7) { i in
                                        HStack {
                                            
                                            if self.currentWeekDays[i] == self.presentDay {
                                                HabitCompleteCheckBoxView(habitID: item.id!,habitName: item.name!, currentIndex: i, weekDays: item.weekDays!)
                                            }else {
                                                DashboardHabitHistory(habitID: item.id!,currentDay: self.currentWeekDays[i], currentIndex: i, weekDays: item.weekDays!)
                                            }
                                            
                                        }
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            }.background(self.colorUtil.getlightGrayColor())
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                                .onTapGesture {
                                    self.isDetailHabitShown.toggle()
                            }
                            .sheet(isPresented: self.$isDetailHabitShown) {
                                HabitDetailView(uuid: item.id!,category: "habit")
                            }
                        }.onDelete { (indexSet) in
                            for offset in indexSet {
                                let habit = self.habitDb[offset]
                                self.moc.delete(habit)
                            }
                            try? self.moc.save()
                        }
                        
                        Text("TASKS FOR TODAY").font(Font.subheadline.weight(.semibold))
                        
                        ForEach(habitDbTasks, id: \.self) { item in
                            HStack {
                                Text("\(item.name!)")
                                .font(Font.headline.weight(.semibold))
                                .onTapGesture {
                                    self.isDetailShown.toggle()
                                }
                                .sheet(isPresented: self.$isDetailShown) {
                                    HabitDetailView(uuid: item.id!, category: "task")
                                }
                                Spacer()
                                TasksCheckBoxView(taskID: item.id!, weekDays: item.weekDays!)
                            }
                        }
                        .onDelete { (indexSet) in
                            for offset in indexSet {
                                let habit = self.habitDbTasks[offset]
                                self.mocTask.delete(habit)
                            }
                            try? self.mocTask.save()
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
        print("delete at \(indexSet)")
    }
    
    private func deleteTask(with indexSet: IndexSet) {
        
    }
}
