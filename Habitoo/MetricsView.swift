//
//  MetricsView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 13/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct MetricsView: View {
    
    @State var on = true
    var sampleData: [CGFloat] = [0,1]
    private var database = DatabaseUtil()
    private var listOfHabits = [Any]()
    private var listOfTasks = [Any]()
    private var arrayHabitName = [String]()
    private var arrayHabitID = [UUID]()
    
    private var arrayTaskName = [String]()
    private var arrayTaskID = [UUID]()
    var collectionUtil = CollectionUtil()
    @State var topHabitsCount = 0
    @State var topHabitsArray = [Int]()
    var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    private var completeDataBaseUtil = CompleteDatabaseUtil()
    
    init() {
        //fetch habits list from database
        listOfHabits = database.fetchHabitsFromDatabase()
        arrayHabitName = listOfHabits[0] as! [String]
        arrayHabitID = listOfHabits[1] as! [UUID]
        
        //fetch tasks list from database
        listOfTasks = database.fetchTasksFromDatabase()
        arrayTaskName = listOfTasks[0] as! [String]
        arrayTaskID = listOfTasks[1] as! [UUID]
    }
    
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var databaseUtil = CompleteDatabaseUtil()
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading,spacing:10) {
                    Text("Statistic").font(.headline).foregroundColor(Color.orange)
                    Spacer()
                    Section(header: Text("Habits").font(Font.headline.weight(.semibold)).foregroundColor(.gray)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(0..<arrayHabitName.count, id: \.self) { index in
                                    HStack {
                                        
                                        NavigationLink(destination: HabitDetailView(uuid: self.arrayHabitID[index], category: "habit")) {
                                            Text("\(self.arrayHabitName[index])")
                                                .padding(8)
                                                .foregroundColor(Color.white)
                                                .background(Color.orange)
                                                .cornerRadius(10)
                                        }
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Tasks").font(Font.headline.weight(.semibold)).foregroundColor(.gray)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(0..<arrayTaskName.count, id: \.self) { index in
                                    HStack {
                                        
                                        NavigationLink(destination: HabitDetailView(uuid: self.arrayTaskID[index], category: "task")) {
                                            Text("\(self.arrayTaskName[index])")
                                                .padding(8)
                                                .foregroundColor(Color.white)
                                                .background(Color.orange)
                                                .cornerRadius(10)
                                        }
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
                Section(header: Text("THIS WEEK").font(Font.subheadline.weight(.semibold))) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(collectionUtil.calculateCompletionByWeek(completion: 2, total: arrayHabitName.count))%")
                            Text("Habits")
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("\(collectionUtil.calculateCompletionByWeek(completion: 7, total: arrayTaskName.count))%")
                            Text("Tasks")
                        }
                        Spacer()
                    }.font(.headline)
                }
                
                Section(header: Text("THIS YEAR").font(Font.subheadline.weight(.semibold))) {
                    VStack(alignment: .center) {
                        
                        HStack {
                          ForEach(0..<12) { month in
                            VStack {
                              Spacer()
                              Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: self.completeDataBaseUtil.calculatePercentageThisYear() * 15.0)
                                Text("\(self.months[month])")
                                .font(.footnote)
                                .frame(height: 20)
                            }
                          }
                        }
                    }
                }
                
                Section(header: Text("ALL TIME").font(Font.subheadline.weight(.semibold))) {
                    VStack(spacing:10) {
                        ForEach(0..<arrayHabitID.count) { index in
                            HStack {
                                Text("\(self.arrayHabitName[index])").foregroundColor(.orange)
                                Spacer()
                                Text("\(self.collectionUtil.calculatePercentage(from: self.databaseUtil.topHabitRecordForThisMonth(hID: self.arrayHabitID[index]),total: self.databaseUtil.topHabitCreatedDaysCount(hID: self.arrayHabitID[index])))%")
                            }.font(.headline)
                            
                        }
                    }
                    VStack(spacing:10) {
                        ForEach(0..<arrayTaskID.count) { index in
                            HStack {
                                Text("\(self.arrayTaskName[index])").foregroundColor(.orange)
                                Spacer()
                                Text("\(self.collectionUtil.calculatePercentage(from: self.databaseUtil.topTasksRecordForThisMonth(tID: self.arrayTaskID[index]),total: self.databaseUtil.topTaskCreatedDaysCount(tID: self.arrayTaskID[index])))%")
                            }.font(.headline)
                            
                        }
                    }
                }
               
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}
