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
    
    var dateUtil = DateUtil()
    var colorUtil = ColorUtil()
    var presentDay: String
    var currentWeekDays = [String]()
    @State var presentDateIndex = 0
    private var database = DatabaseUtil()
    private var listOfHabits = [Any]()
    private var listOfTasks = [Any]()
    private var collectionUtil = CollectionUtil()
    
    private var arrayHabitName = [String]()
    private var arrayHabitID = [UUID]()
    
    private var arrayTaskName = [String]()
    private var arrayTaskID = [UUID]()
    
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
    }
    
    var body: some View {
        VStack {
            List {
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
                                Text("S")
                            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                
                                .background(Color.orange)
                            .cornerRadius(10)
                                .foregroundColor(Color.white)
                        } else {
                        VStack {
                            Text("\(self.currentWeekDays[index])")
                            .foregroundColor(Color.orange)
                            Text("S")
                            .foregroundColor(Color.gray)
                        }
                            
                        }
                        Spacer()
                    }
                }
                //section for last week record
                Section(header: Text("HABITS FOR TODAY").font(Font.subheadline.weight(.semibold))) {
                    VStack {
                        ForEach(0..<arrayHabitName.count) { index in
                        VStack(alignment: .leading) {
                            Text("\(self.arrayHabitName[index])").padding()
                        .font(Font.headline.weight(.semibold))
                            .foregroundColor(.orange)
                                
                        HStack {
                            ForEach(0..<7) { index in
                                if index == self.presentDateIndex {
                                    Image(systemName: "smallcircle.fill.circle")
                                        .font(.title)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .foregroundColor(.orange)
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
                    }
                    Text("You only 1 habit to do today!")
                        .foregroundColor(Color.gray).font(.subheadline)
                
                }
                //section for task list
                Section(header: Text("TASKS FOR TODAY").font(Font.subheadline.weight(.semibold))) {
                    VStack(alignment: .leading) {
                        ForEach(0..<arrayTaskName.count) { index in
                            HStack {
                                Image(systemName: "stop")
                                    .foregroundColor(Color.orange)
                                    .font(Font.title.weight(.medium))
                                    .padding(5)
                                Text("\(self.arrayTaskName[index])")
                                .font(Font.headline.weight(.semibold))
                                
                            }
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
        }
    }
}

