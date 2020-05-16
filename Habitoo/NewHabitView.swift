//
//  NewHabbitView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 13/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct NewHabitView: View{
    
    @State var habitName: String = ""
    @State var isHabit = true
    let weeDays = ["S","M","T","W","T","F","S"]
    @State var selectedWeekDays = [Int]()
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15) {
            HStack {
                Spacer()
                if isHabit {
                    Text("Habit").padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(20)
                        .onTapGesture {
                            self.isHabit.toggle()
                    }
                     Spacer()
                     Text("Task").font(.headline)
                    .onTapGesture {
                            self.isHabit.toggle()
                    }
                } else {
                     Text("Habit").font(.headline)
                    .onTapGesture {
                            self.isHabit.toggle()
                    }
                     Spacer()
                     Text("Task").padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(20)
                    .onTapGesture {
                            self.isHabit.toggle()
                    }
                }
                
                
                Spacer()
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            TextField("Name", text: $habitName).font(.headline)
            Divider().background(Color.orange)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        
            HStack {
                Image(systemName: "calendar").foregroundColor(Color.gray)
                Text("Everyday").font(.headline)
            }
            HStack {
                ForEach(0..<7) { index in
                    Button(action: {
                        
                    }) {
                        Text("S")
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                Image(systemName: "stop").font(.title)
                Text("Receive a reminder").font(.headline)
            }.foregroundColor(Color.gray)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                Button(action: {
                    
                }) {
                    Text("Cancel").foregroundColor(Color.black).font(.headline)
                }
                Spacer()
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "plus")
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                        Text("Add").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }.font(.headline)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                    .cornerRadius(20)
                }
            }
            Spacer()
        }.padding()
        .accentColor(.orange)
    }
}
