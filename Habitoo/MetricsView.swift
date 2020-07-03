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
                        VStack {
                            Text("3")
                            Text("Habits")
                        }
                        Spacer()
                        VStack {
                            Text("15")
                            Text("Completion")
                        }
                        Spacer()
                        VStack {
                            Text("75%")
                            Text("Complete")
                        }
                    }.font(.headline)
                }
                
                Section(header: Text("THIS MONTH").font(Font.subheadline.weight(.semibold))) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("55%")
                            Text("Complete")
                        }.font(.headline)
                        
                        VStack {
                            LineGraph(dataPoints: sampleData)
                                .trim(to: on ? 1 : 0)
                                .stroke(Color.orange, lineWidth: 2)
                                .aspectRatio(16/9, contentMode: .fit)
                                .border(Color.gray, width: 1)
                                .padding()
                        }
                    }
                }
                
                Section(header: Text("TOP HABITS").font(Font.subheadline.weight(.semibold))) {
                    VStack(spacing:10) {
                        ForEach(0..<10) { index in
                            HStack {
                                Text("Meditate in the morning")
                                Spacer()
                                Text("44%").foregroundColor(Color.orange)
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
