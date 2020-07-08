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
    @State var convertToInt = [Int]()
    @State var consecutiveDays = [[Int]]()
    @State var consecutiveThreeDays = [Any]()
    @State var consecutiveSixDays = [Any]()
    @State var consecutiiveTenDays = [Any]()
    var data = [[1,2,3],[4,5,6],[7,8,9]]
    
    init(id: UUID) {
        self.taskID = id
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            ForEach(consecutiveDays, id:\.self) { array in
                    VStack(alignment:.leading,spacing: 10) {
                        //if find three consecutive days of completion
                        if array.count == 3 {
                            Text("\(self.dateUtil.getCurrentMonth()), \(array[array.startIndex]) - \(array[array.endIndex - 1])")
                                .font(Font.headline.weight(.semibold))
                                .foregroundColor(.orange)
                            Text("You Have new record! As many as 3 days of stable completion.")
                                .font(Font.headline.weight(.medium))
                                .foregroundColor(.gray)
                        }
                        //if find five consecutive days of completion
                        else if array.count == 5 {
                            Text("\(self.dateUtil.getCurrentMonth()), \(array[array.startIndex]) - \(array[array.endIndex - 1])").padding()
                                .font(Font.headline.weight(.semibold))
                                .foregroundColor(.orange)
                            Text("You Have new record! As many as 5 days of stable completion.").padding()
                                .font(Font.headline.weight(.medium))
                                .foregroundColor(.gray)
                        }
                        //if find seven consecutive days of completion
                        else if array.count == 7 {
                            Text("\(self.dateUtil.getCurrentMonth()), \(array[array.startIndex]) - \(array[array.endIndex - 1])")
                                .font(Font.headline.weight(.semibold))
                                .foregroundColor(.orange)
                            Text("You Have new record! As many as 7 days of stable completion.")
                                .font(Font.headline.weight(.medium))
                                .foregroundColor(.gray)
                        }
                    }
            }
        }.onAppear(){
            self.fetchResultFromDatabase = self.databaseUtil.taskRecordForThisMonth(tID: self.taskID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            //convert string array to int array
            self.convertToInt = self.fetchResultFromDatabaseFiltered.map { Int($0)!}
            
            //let myNumbersArray = [1,2,3,5,10,11,13,14,15,20,21,22,23,24,25,29,30,31]
            let indexSet = IndexSet(self.convertToInt)
            let rangeView = indexSet.rangeView
            self.consecutiveDays = rangeView.map { Array($0.indices) }
            
            print(self.consecutiveDays)
            //print("filtered data - \(self.fetchResultFromDatabaseFiltered)")
        }
    }
}
