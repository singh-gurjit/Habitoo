//
//  NewHabbitView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 13/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct NewHabitView: View{
    
    @State var habitName: String = ""
    @State var isHabit = true
    let weekDays = ["S","M","T","W","T","F","S"]
    @State var selectedWeekDays = [Int]()
    @State var isReminderSet = false
    @State var remAlarm: Date = Date()
    @State var currrentType: String = "habit"
    @State var isNameEmpty = false
    private var database = DatabaseUtil()
    private var date = Date()
    private var collectionUtil = CollectionUtil()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15) {
            HStack {
                Spacer()
                if isHabit {
                    Text("Habit").padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(20)
                        .onTapGesture {
                            self.isHabit.toggle()
                            self.currrentType = "habit"
                    }
                     Spacer()
                     Text("Task").font(.headline)
                    .onTapGesture {
                            self.isHabit.toggle()
                            self.currrentType = "task"
                    }
                } else {
                     Text("Habit").font(.headline)
                    .onTapGesture {
                            self.isHabit.toggle()
                    }
                     Spacer()
                     Text("Task").padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(20)
                    .onTapGesture {
                            self.isHabit.toggle()
                    }
                }
                
                
                Spacer()
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            TextField("Name", text: $habitName).font(.headline)
            Divider().background(Color.orange)
            HStack {
                if self.isNameEmpty {
                    Text("* Please fill name").foregroundColor(.red)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        
            HStack {
                Image(systemName: "calendar").foregroundColor(Color.gray)
                Text("Days").font(.headline)
            }
            HStack {
                ForEach(0..<7) { index in
                    if self.selectedWeekDays.contains(index) {
                    Button(action: {
                        
                    }) {
                        Text("\(self.weekDays[index])")
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .onTapGesture {
                                    //get index of element
                                    if let findIndex = self.selectedWeekDays.firstIndex(of: index) {
                                        self.selectedWeekDays.remove(at: findIndex)
                                    }
                            }
                    }
                    } else {
                        Button(action: {
                            
                        }) {
                            Text("\(self.weekDays[index])")
                                .foregroundColor(Color.orange)
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .border(Color.orange, width: 1)
                                .cornerRadius(1)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .onTapGesture {
                                        self.selectedWeekDays.append(index)
                                }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                if self.isReminderSet {
                    Image(systemName: "checkmark.square").font(.title).foregroundColor(Color.black)
                    .onTapGesture {
                        self.isReminderSet.toggle()
                    }
                } else {
                    Image(systemName: "stop").font(.title).foregroundColor(Color.gray)
                    .onTapGesture {
                        self.isReminderSet.toggle()
                    }
                   
                }
                 Text("Receive a reminder").font(.headline).foregroundColor(Color.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                if self.isReminderSet {
                    DatePicker("", selection: $remAlarm, displayedComponents: .hourAndMinute)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                Button(action: {
                    
                }) {
                    Text("Cancel").foregroundColor(Color.black).font(.headline)
                }
                Spacer()
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "plus")
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                        Text("Add").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                            .onTapGesture {
                                if self.habitName != "" {
//                                print("Success Name: \(self.$habitName) + \(self.currrentType) + \(self.selectedWeekDays) + \(self.isReminderSet) + \(self.remAlarm)")
                                    self.database.createNewHabit(name: self.habitName, category: self.currrentType, cDate: self.date, isReminder: self.isReminderSet, reminder: self.remAlarm, weekDays: self.collectionUtil.arrayToString(array: self.selectedWeekDays))
                                    self.isNameEmpty.toggle()
                                    self.habitName = ""
                                    self.presentationMode.wrappedValue.dismiss()
                                } else {
                                    self.isNameEmpty.toggle()
                                }
                        }
                    }.font(.headline)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                    .cornerRadius(20)
                }
            }
            Spacer()
        }.padding()
        .accentColor(.orange)
    }
}
