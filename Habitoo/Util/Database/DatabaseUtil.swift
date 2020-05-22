//
//  DatabaseUtil.swift
//  Habitoo
//
//  Created by Gurjit Singh on 15/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class DatabaseUtil {
    
    var date = Date()
    
    func createNewHabit(name: String, category: String, cDate: Date, isReminder: Bool,reminder: Date, weekDays: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let moc = appDelegate.persistentContainer.viewContext
        let habitEntity = NSEntityDescription.entity(forEntityName: "Habits", in: moc)!
        let habit = NSManagedObject(entity: habitEntity, insertInto: moc)
        
        //insert data
        habit.setValue(UUID(), forKey: "id")
        habit.setValue(name, forKey: "name")
        habit.setValue(cDate, forKey: "createdDate")
        habit.setValue(reminder, forKey: "reminderTime")
        habit.setValue(weekDays, forKey: "weekDays")
        habit.setValue(category, forKey: "category")
        habit.setValue(isReminder, forKey: "isReminder")
        do {
            try moc.save()
            print("Saved..")
        } catch let error as NSError {
            print("Error while saving.. \(error.userInfo)")
        }
        
    }
    
}
