//
//  EditHabitView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 27/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct EditHabitView: View {
    @State var habitName: String = ""
    @State var uuid: UUID
    var databaseUtil = DatabaseUtil()
     @State private var deletedSuccess = false
    
    var body: some View {
        NavigationView {
        VStack(alignment: .leading,spacing: 15) {
            Text("Edit Habit").font(.title).foregroundColor(Color.orange)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                .onAppear() {
                    print("uuid : \(self.uuid)")
            }
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
                    self.deletedSuccess = true
                }) {
                    Text("Delete").padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .background(Color.gray)
                        .cornerRadius(20)
                }.alert(isPresented: $deletedSuccess) {
                    Alert(title: Text("Delete"), message: Text("Are you sure you want to delete?"), primaryButton: .destructive(Text("Delete")) {
                            self.databaseUtil.deleteHabit(uuid: self.uuid)
                            
                    }, secondaryButton: .cancel())
                }
                
                Button(action: {
                    
                }) {
                    Text("Done").padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
            }
            Spacer()
        }.padding()
            .accentColor(.orange)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    }
}
