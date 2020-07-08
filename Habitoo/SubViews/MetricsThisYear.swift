//
//  MetricsThisYear.swift
//  Habitoo
//
//  Created by Gurjit Singh on 08/07/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct MetricsThisYear: View {
    
    private var completeDataBaseUtil = CompleteDatabaseUtil()
    var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    var body: some View {
        HStack {
          ForEach(0..<12) { month in
            VStack {
              Spacer()
                HStack(alignment: .bottom, spacing: 0) {
              Rectangle()
                .fill(Color.orange)
                .frame(width: 12, height: self.completeDataBaseUtil.calculatePercentageThisYearHabit(month: month) * 15.0)
                Rectangle()
                .fill(Color.green)
                    .frame(width: 12, height: self.completeDataBaseUtil.calculatePercentageThisYearTask(month: month) * 15.0)
                }
                Text("\(self.months[month])")
                .font(.footnote)
                .frame(height: 20)
            }
          }
        }
    }
}
