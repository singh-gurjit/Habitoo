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
    //fetch current week record
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var databaseUtil = CompleteDatabaseUtil()
    var dateUtil = DateUtil()
    
    var body: some View {
        VStack {
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
           
        }.onAppear() {
            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            print("\(self.fetchResultFromDatabaseFiltered)")
        }
    }
}
