//
//  DayCalendarHabit.swift
//  Habitoo
//
//  Created by Gurjit Singh on 28/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct DayCalendarHabit: View {
    
    var dateUtil = DateUtil()
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var databaseUtil = CompleteDatabaseUtil()
    var habitID: UUID = UUID()
    var currentDay = ""
    
    init(id: UUID) {
        self.habitID = id
        currentDay = dateUtil.getCurrentDay()
    }
    
    var body: some View {
        VStack {
            if fetchResultFromDatabaseFiltered.contains(self.currentDay) {
                Image(systemName: "\(self.currentDay).circle.fill").font(.largeTitle)
                .foregroundColor(.gray)
            } else {
                Image(systemName: "\(self.currentDay).circle").font(.largeTitle)
                .foregroundColor(.gray)
            }
         
        }.onAppear() {
            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
        }
    }
}
