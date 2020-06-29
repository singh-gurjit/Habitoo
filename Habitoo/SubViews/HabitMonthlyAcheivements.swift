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
    
    init(id: UUID) {
        self.habitID = id
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
            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID) as! [Date]
            self.fetchResultFromDatabaseFiltered = self.dateUtil.filterDateFromCurrentMonth(array: self.fetchResultFromDatabase)
            
            self.convertToInt = self.fetchResultFromDatabaseFiltered.map { Int($0)!}
            
            let input = [1,2,4,6,7,10,12,13,14,18,19,33]
            //check two elements and compare them and find element consecutive
            let output = stride(from: 0, to: input.count - 1, by: 2).map{(input[$0], input[$0 + 1])}
            //differences between elements
            let differences = output.map({ $0.1 - $0.0 })
            //how many are consitence
            let onesCount = differences.filter({ $0 == 1}).count
            let twoCount = differences.filter({ $0 == 2}).count
            let threeCount = differences.filter({ $0 == 7}).count

            print(differences)
            print(onesCount)
            print(twoCount)
            print(threeCount)
            
            print("filtered data - \(self.fetchResultFromDatabaseFiltered)")
        }
    }
}

