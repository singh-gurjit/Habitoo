//
//  DashboardHabitHistory.swift
//  Habitoo
//
//  Created by Gurjit Singh on 08/07/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct DashboardHabitHistory: View {
    
    @State var habitID: UUID
    @State var currentDay: String
    @State var currentIndex: Int
    //fetch current week record
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var databaseUtil = CompleteDatabaseUtil()
    var dateUtil = DateUtil()
    @State var weekDays: String
    var collectionUtil = CollectionUtil()
    @State var arrayWeekDays = [String]()
    
    var body: some View {
        VStack {
            if self.arrayWeekDays.contains("\(currentIndex)") {
                if self.fetchResultFromDatabaseFiltered.contains("\(self.currentDay)") {
                    Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            } else {
                Image(systemName: "minus")
                .font(.headline)
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity)
                    .opacity(0.5)
            }
            
           
        }.onAppear() {
            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            //print("\(self.fetchResultFromDatabaseFiltered)")
            self.arrayWeekDays = self.collectionUtil.stringToArray(string: self.weekDays)
            //print(self.arrayWeekDays)
        }
    }
}
