//
//  HabitMonthlyAcheivements.swift
//  Habitoo
//
//  Created by Gurjit Singh on 28/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct HabitMonthlyAcheivements: View {
    
    var habitID: UUID = UUID()
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
        self.habitID = id
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ForEach(consecutiveDays, id:\.self) { array in
                ForEach(array, id:\.self) { element in
                    VStack(alignment:.leading) {
                        if array.count == 3 {
                            Text("November, \(array.startIndex + 1) - \(array.endIndex)").padding()
                                .font(Font.headline.weight(.semibold))
                                .foregroundColor(.orange)
                            Text("You Have new record! As many as 3 days of stable training").padding()
                                .font(Font.headline.weight(.medium))
                                .foregroundColor(.gray)
                        } else if array.count == 6 {
                            Text("November, \(array.startIndex + 1) - \(array.endIndex)").padding()
                                .font(Font.headline.weight(.semibold))
                                .foregroundColor(.orange)
                            Text("You Have new record! As many as 6 days of stable training").padding()
                                .font(Font.headline.weight(.medium))
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
            }
        }.onAppear(){
            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            //convert string array to int array
            self.convertToInt = self.fetchResultFromDatabaseFiltered.map { Int($0)!}
            
            let myNumbersArray = [1,2,3,5,10,11,15,20,21,22,23,24,25,29,30]
            let indexSet = IndexSet(myNumbersArray)
            let rangeView = indexSet.rangeView
            self.consecutiveDays = rangeView.map { Array($0.indices) }
            
            print(self.consecutiveDays)
//            for (_, item) in dateArray.enumerated() {
//                for _ in item {
//                    //print("index: \(index), item: \(item), \(item.count)")
//                    if item.count == 3 {
//                        self.consecutiveThreeDays.append(item)
//                    } else if item.count == 6 {
//                        self.consecutiveSixDays.append(item)
//                    } else if item.count == 10 {
//                        print("hola ten consecutive days")
//                    }
//                }
//            }
            print("filtered data - \(self.fetchResultFromDatabaseFiltered)")
        }
    }
}

