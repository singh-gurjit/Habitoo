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
    @State var fetchResult = [Any]()
    @State var fetchResultHabitId = [UUID]()
    @State var fetchResultId = [UUID]()
    var date = Date()
    var collectionUtil = CollectionUtil()
    @State var isHabitComplete = false
    @State var completedHabitIndex = 0
    @State var currentIndex: Int
    @State var weekDays: String
    @State var arrayWeekDays = [String]()
    
    var body: some View {
        
        Button(action: {
            
        }) {
            //check habit completed or not and display completed circle according to it
            if self.arrayWeekDays.contains("\(currentIndex)") {
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
            } else {
                Image(systemName: "minus")
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.gray)
                    .opacity(0.5)
            }
            
        }.onTapGesture {
            self.isHabitComplete.toggle()
            //check if habit completed or not and insert record in database
            if self.isHabitComplete {
                print("added..\(self.habitID)")
                self.completeDatabaseUtil.insertCompletedHabit(habitName: self.habitName, uuid: self.habitID, cDate: self.collectionUtil.dateFormat(date: self.date))
            } else {
                //self.completeDatabaseUtil.deleteHabitCompleted(id: self.fetchResultId[self.completedHabitIndex])
                self.completeDatabaseUtil.deleteHabitCompleted(id: self.habitID)
                //self.fetchResultId.remove(at: self.completedHabitIndex)
                //self.fetchResultHabitId.remove(at: self.completedHabitIndex)
            }
        }.onAppear() {
            self.fetchResult = self.completeDatabaseUtil.fetchTodaysHabits(cDate: self.collectionUtil.dateFormat(date: self.date))
            //check if record is empty or not
            if !self.fetchResult.isEmpty {
                self.fetchResultHabitId = self.fetchResult[0] as! [UUID]
                self.fetchResultId = self.fetchResult[1] as! [UUID]
            }
            //print("Result - \(self.fetchResult), \(self.habitID), Result id- \(self.fetchResultHabitId )")
            
            //toggle completed habit
            if self.fetchResultHabitId.contains(self.habitID) {
                self.isHabitComplete = true
                self.completedHabitIndex = self.fetchResultHabitId.firstIndex(of: self.habitID)!
            } else {
                //print("false")
                self.isHabitComplete = false
            }
            self.arrayWeekDays = self.collectionUtil.stringToArray(string: self.weekDays)
        }
        
    }
}
