//
//  TaskMonthlyAcheivements.swift
//  Habitoo
//
//  Created by Gurjit Singh on 28/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct TaskMonthlyAcheivements: View {
    
    var taskID: UUID = UUID()
    var databaseUtil = CompleteDatabaseUtil()
    @State var fetchResultFromDatabase = [Date]()
    @State var fetchResultFromDatabaseFiltered = [String]()
    var dateUtil = DateUtil()
    
    init(id: UUID) {
        self.taskID = id
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("November, 20 - 23").padding()
                .font(Font.headline.weight(.semibold))
                .foregroundColor(.orange)
            Text("You Have new record! As many as 4 days of stable training").padding()
                .font(Font.headline.weight(.medium))
                .foregroundColor(.gray)
        }.onAppear(){
            self.fetchResultFromDatabase = self.databaseUtil.taskRecordForThisMonth(tID: self.taskID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            //print("filtered data - \(self.fetchResultFromDatabaseFiltered)")
        }
    }
}
