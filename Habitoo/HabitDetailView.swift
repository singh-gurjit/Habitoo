//
//  HabitDetailView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 14/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct HabitDetailView: View {
    
    let rows = 5
    let columns = 7
    @State var isEditHabbitShown = false
    @State var uuid: UUID
    @Environment(\.presentationMode) var presentationMode
    var weekDays = ["S","M","T","W","T","F","S"]
    var calendarUtil = CalenderUtil()
    var items = [[Date]]()
    @State var category: String
    @State var currentViewType = "month"
    var database = DatabaseUtil()
    @State var showDeleteAlert = false
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("Cancel").font(.headline)
                    }
//                    Image(systemName: "chevron.left").foregroundColor(.orange)
//                        .font(Font.title.weight(.semibold))
                    .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Text("\(self.database.fetchHabitName(hid: uuid))").foregroundColor(.gray)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Edit").font(.headline)
                    }
//                    Image(systemName: "pencil.circle").foregroundColor(.orange)
//                        .font(Font.title.weight(.semibold))
                        .onTapGesture {
                            self.isEditHabbitShown.toggle()
                    }.sheet(isPresented: self.$isEditHabbitShown) {
                        EditHabitView(uuid: self.uuid)
                    }.padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
//                    Image(systemName: "trash").foregroundColor(.orange)
//                       .font(.system(size: 25))
//                        .onTapGesture {
//                            //self.isEditHabbitShown.toggle()
//                            self.showDeleteAlert.toggle()
//                        }.alert(isPresented: $showDeleteAlert) {
//                        //display alert before delete
//                        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete?"), primaryButton: .destructive(Text("Delete")) {
//                            //call function to delete particular habit
//                            self.database.deleteHabit(uuid: self.uuid)
//                            //dismiss view
//                            self.presentationMode.wrappedValue.dismiss()
//                            }, secondaryButton: .cancel())
                    //}.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                
                Divider()
                HStack {
                    Spacer()
                    if currentViewType == "day" {
                        Text("Day").foregroundColor(.white)
                            .padding(8)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.currentViewType = "day"
                        }
                        Spacer()
                        Text("Week").foregroundColor(.orange)
                            .onTapGesture {
                                self.currentViewType = "week"
                        }
                        Spacer()
                        Text("Month").foregroundColor(.orange)
                            .onTapGesture {
                                self.currentViewType = "month"
                        }
                    } else if currentViewType == "week" {
                        Text("Day").foregroundColor(.orange)
                            .onTapGesture {
                                self.currentViewType = "day"
                        }
                        Spacer()
                        Text("Week").foregroundColor(.white)
                            .padding(8)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.currentViewType = "week"
                        }
                        Spacer()
                        Text("Month").foregroundColor(.orange)
                            .onTapGesture {
                                self.currentViewType = "month"
                        }
                    } else {
                        Text("Day").foregroundColor(.orange)
                            .onTapGesture {
                                self.currentViewType = "day"
                        }
                        Spacer()
                        Text("Week").foregroundColor(.orange)
                            .onTapGesture {
                                self.currentViewType = "week"
                        }
                        Spacer()
                        Text("Month").foregroundColor(.white)
                            .padding(8)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.currentViewType = "month"
                        }
                    }
                    
                    Spacer()
                    //Text("Year").foregroundColor(.orange)
                }.padding()
                
                VStack(alignment: .center) {
                    
                    //display calender monthly
                    if currentViewType == "month" {
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(0..<7, id: \.self) { index in
                                Text("\(self.weekDays[index])").frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.headline)
                            }
                        }
                        //check if category is habit or task
                        if category == "habit" {
                            GridCalender(id: uuid)
                        } else {
                            GridCalendarTask(id: uuid)
                        }
                        //display weekly calendar
                    } else if currentViewType == "week" {
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(0..<7, id: \.self) { index in
                                Text("\(self.weekDays[index])").frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.headline)
                            }
                        }
                        if category == "habit" {
                            WeeklyCalendarHabit(id: uuid)
                        } else {
                            WeeklyCalendarTask(id: uuid)
                        }
                    } else {
                        if category == "habit" {
                            DayCalendarHabit(id: uuid)
                        } else {
                            DayCalendarTask(id:uuid)
                        }
                    }
            }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 2)
                        .opacity(0.1)
            )
            
            VStack(spacing: 10) {
                //show acheivements
                   
                        if self.category == "habit" {
                            HabitMonthlyAcheivements(id: self.uuid)
                        } else {
                            TaskMonthlyAcheivements(id: self.uuid)
                        }
                
                }.padding()
        }
    }.listStyle(GroupedListStyle())
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .accentColor(Color.orange)
}
}
