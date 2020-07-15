//
//  EditHabitView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 27/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct EditHabitView: View {
    @State var habitName: String = ""
    @State var uuid: UUID = UUID()
    var databaseUtil = DatabaseUtil()
    @State private var deletedSuccess = false
    @Environment(\.presentationMode) var presentationMode
    var fetchRecordByID = [Any]()
    @State var isHabit = true
    @State var currrentType: String = "habit"
    @State var isReminderSet = false
    @State var remAlarm: Date = Date()
    @State var isNameEmpty = false
    var collectionUtil = CollectionUtil()
    let weekDays = ["S","M","T","W","T","F","S"]
    @State var selectedWeekDays = [Int]()
    @State var successDeletion = 0
    
    init(uuid: UUID) {
        self.uuid = uuid
        fetchRecordByID = databaseUtil.fetchRecordByID(uuid: uuid)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing: 15) {
//                HStack {
//                    Spacer()
//                    if isHabit {
//                        Text("Habit").padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
//                            .font(.headline)
//                            .foregroundColor(Color.white)
//                            .background(Color.orange)
//                            .cornerRadius(20)
//                            .onTapGesture {
//                                self.isHabit.toggle()
//                                self.currrentType = "habit"
//                        }
//                        Spacer()
//                        Text("Task").font(.headline)
//                            .onTapGesture {
//                                self.isHabit.toggle()
//                                self.currrentType = "task"
//                        }
//                    } else {
//                        Text("Habit").font(.headline)
//                            .onTapGesture {
//                                self.isHabit.toggle()
//                        }
//                        Spacer()
//                        Text("Task").padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
//                            .font(.headline)
//                            .foregroundColor(Color.white)
//                            .background(Color.orange)
//                            .cornerRadius(20)
//                            .onTapGesture {
//                                self.isHabit.toggle()
//                        }
//                    }
//
//
//                    Spacer()
//                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
                TextField("Name", text: $habitName).font(.headline)
                    .onAppear() {
                        self.uuid = self.fetchRecordByID[5] as! UUID
                        self.habitName = self.fetchRecordByID[0] as! String
                        self.isReminderSet = self.fetchRecordByID[2] as! Bool
                        if self.isReminderSet {
                            self.remAlarm = self.fetchRecordByID[3] as! Date
                        }
                        //fetch weekdays
                        let weekDays = self.fetchRecordByID[4] as! String
                        //if weekdays are not nil
                        if weekDays != "" {
                            //convert string to integer array
                            self.selectedWeekDays = self.collectionUtil.stringToIntArray(string: weekDays)
                        }
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                Divider().background(Color.orange)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                
                HStack {
                    Image(systemName: "calendar").foregroundColor(Color.gray)
                    Text("Everyday").font(.headline)
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
                    //Set reminder notification
//                HStack {
//                    if self.isReminderSet {
//                        Image(systemName: "checkmark.square").font(.title).foregroundColor(Color.black)
//                            .onTapGesture {
//                                self.isReminderSet.toggle()
//                        }
//                    } else {
//                        Image(systemName: "stop").font(.title).foregroundColor(Color.gray)
//                            .onTapGesture {
//                                self.isReminderSet.toggle()
//                        }
//
//                    }
//                    Text("Receive a reminder").font(.headline).foregroundColor(Color.gray)
//                }
//                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
//                HStack {
//                    if self.isReminderSet {
//                        DatePicker("", selection: $remAlarm, displayedComponents: .hourAndMinute)
//                    }
//                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel").foregroundColor(Color.black).font(.headline)
                    }
                    Spacer()
//                    Button(action: {
//                        self.deletedSuccess = true
//                    }) {
//                        Text("Delete").padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
//                            .font(.headline)
//                            .foregroundColor(Color.white)
//                            .background(Color.gray)
//                            .cornerRadius(20)
//                    }.alert(isPresented: $deletedSuccess) {
//                        //display alert before delete
//                        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete?"), primaryButton: .destructive(Text("Delete")) {
//                            //call function to delete particular habit
//                            self.databaseUtil.deleteHabit(uuid: self.uuid)
//                            //dismiss view
//                            self.presentationMode.wrappedValue.dismiss()
//                            }, secondaryButton: .cancel())
//                    }
                    
                    Button(action: {
                        
                    }) {
                        Text("Done").padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .background(Color.orange)
                            .cornerRadius(20)
                            .onTapGesture {
                                if self.databaseUtil.fetchHabitType(hid: self.uuid) == "habit" {
                                      self.databaseUtil.updateHabitRecord(uuid: self.uuid, name: self.habitName, category: "habit", isReminder: self.isReminderSet, remTime: self.remAlarm, weekDays: self.collectionUtil.arrayToString(array: self.selectedWeekDays))
                                }
                                else {
                                   self.databaseUtil.updateHabitRecord(uuid: self.uuid, name: self.habitName, category: "task", isReminder: self.isReminderSet, remTime: self.remAlarm, weekDays: self.collectionUtil.arrayToString(array: self.selectedWeekDays))
                                }
                            
                                self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                Spacer()
            }.padding()
                .accentColor(.orange)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}
