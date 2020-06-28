//
//  WeeklyCalendarHabit.swift
//  Habitoo
//
//  Created by Gurjit Singh on 27/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct WeeklyCalendarHabit: View {
    let rows = 5
    let columns = 7
    let days = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    var currentDate = 1
    @State var hiddenView = false
    var weeks = 0
    var items = [[Date]]()
    lazy var dateFormatter: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var date = Date()
    var habitID: UUID = UUID()
    var databaseUtil = CompleteDatabaseUtil()
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var dateUtil = DateUtil()
    let formatter = DateFormatter()
    var currentWeekDays = [String]()
    
    init(id: UUID) {
        self.habitID = id
        currentWeekDays = dateUtil.currentWeekDays()
    }
    var completeDate = [Date]()
    
    var body: some View {
        VStack {
            
                HStack(spacing: 15) {
                    ForEach(0 ..< 7, id: \.self) { index in
                        //self.content(row, column)
                        VStack {
                            if self.fetchResultFromDatabaseFiltered.contains("\(self.currentWeekDays[index])") {
                            Image(systemName: "\(self.currentWeekDays[index]).circle.fill").font(.largeTitle)
                            .foregroundColor(.gray)
                            } else {
                                Image(systemName: "\(self.currentWeekDays[index]).circle").font(.largeTitle)
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }.padding(10)
            
        }.frame(maxWidth: .infinity)
        .onAppear(){
            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            //print("filtered data - \(self.fetchResultFromDatabaseFiltered)")
        }
    }

}
