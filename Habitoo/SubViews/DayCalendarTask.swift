//
//  DayCalendarTask.swift
//  Habitoo
//
//  Created by Gurjit Singh on 28/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct DayCalendarTask: View {
    var dateUtil = DateUtil()
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var databaseUtil = CompleteDatabaseUtil()
    var taskID: UUID = UUID()
    var currentDay = ""
    
    init(id: UUID) {
        self.taskID = id
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
            self.fetchResultFromDatabase = self.databaseUtil.taskRecordForThisMonth(tID: self.taskID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
        }
    }
}
