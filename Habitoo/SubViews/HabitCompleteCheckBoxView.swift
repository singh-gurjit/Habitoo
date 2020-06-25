//
//  HabitCompleteCheckBoxView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 06/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct HabitCompleteCheckBoxView: View {
    
    @State var habitID: UUID
    @State var habitName: String
    @ObservedObject var completeDatabaseUtil = CompleteDatabaseUtil()
    @State var fetchResult = [UUID]()
    var date = Date()
    var collectionUtil = CollectionUtil()
    @State var isHabitComplete = false
    
    var body: some View {
        /*
        Button(action: {
            
        }) {
            if isHabitComplete {
                Image(systemName: "checkmark.circle")
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.orange)
                .onAppear() {
                    
                    self.fetchResult = self.completeDatabaseUtil.fetchTodaysHabits(cDate: self.collectionUtil.dateFormat(date: self.date))
                    print("habb - \(self.habitID) , \(self.fetchResult)")
                    if self.fetchResult.contains(self.habitID) {
                        print("found")
                        self.isHabitComplete = true
                    } else {
                        print("not found")
                        self.isHabitComplete = false
                    }
                }.onTapGesture {
                    print("deleted")
                    self.isHabitComplete = false
                }
            } else {
                Image(systemName: "circle")
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.orange)
                .onAppear() {
                    
                    self.fetchResult = self.completeDatabaseUtil.fetchTodaysHabits(cDate: self.collectionUtil.dateFormat(date: self.date))
                    print("habb - \(self.habitID), \(self.fetchResult)")
                    if self.fetchResult.contains(self.habitID) {
                        print("found")
                        self.isHabitComplete = true
                    } else {
                        print("not found")
                        self.isHabitComplete = false
                    }
                }
                .onTapGesture {
                    print("added")
                    self.isHabitComplete = true
                }
            }
            
        }
    */
    Button(action: {
        
    }) {
        if fetchResult.contains(habitID) {
            
        }
        //check habit completed or not and display completed circle according to it
        if isHabitComplete {
            Image(systemName: "checkmark.circle")
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.orange)
        } else {
            Image(systemName: "circle")
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.orange)
        }
    }.onTapGesture {
        self.isHabitComplete.toggle()
        //check if habit completed or not and insert record in database
        if self.isHabitComplete {
            print("added..\(self.habitID)")
            self.completeDatabaseUtil.insertCompletedHabit(habitName: self.habitName, uuid: self.habitID, cDate: self.collectionUtil.dateFormat(date: self.date))
        } else {
            print("removed..\(self.habitID)")
        }
        }.onAppear() {
        self.fetchResult = self.completeDatabaseUtil.fetchTodaysHabits(cDate: self.collectionUtil.dateFormat(date: self.date))
            print("Result - \(self.fetchResult)")
        }
    
    }
}
