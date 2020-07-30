//
//  FetchRecord.swift
//  Habitoo
//
//  Created by Gurjit Singh on 29/07/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

class FetchRecord: ObservableObject {
    @Published var toggle: Bool = false
    
    //private var date = Date()
    var dateUtil = DateUtil()
    //var colorUtil = ColorUtil()
    @Published var presentDay: String
    @Published var currentWeekDays = [String]()
    @Published var presentDateIndex = 0
    private var database = DatabaseUtil()
    @Published var listOfHabits = [Any]()
    @Published var listOfTasks = [Any]()
    private var collectionUtil = CollectionUtil()
    //var weekDay = ["S","M","T","W","T","F","S"]
    
    @Published var arrayHabitName = [String]()
    @Published var arrayHabitID = [UUID]()
    @Published var arrayHabitWeekDays = [String]()
    
    @Published var arrayTaskName = [String]()
    @Published var arrayTaskID = [UUID]()
    @Published var arrayTaskWeekDays = [String]()
    
    @ObservedObject var completeDatabaseUtil = CompleteDatabaseUtil()
    
    //tasks completed record
    @Published var listOfTasksComplete = [Any]()
    //private var arrayTaskNameComplete = [String]()
    @Published var arrayTaskIDComplete = [UUID]()
    @Published var arrayTaskUUIDComplete = [UUID]()
    @Published var arrayTaskDateComplete = [Date]()
    
    //var completedTaskFound = false
    @Published var isHabitCompleteBtn = false
    @Published var listOfHabitsComplete = [Any]()
    @Published var arrayHabitUUIDComplete = [UUID]()
    
    init() {
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
}
