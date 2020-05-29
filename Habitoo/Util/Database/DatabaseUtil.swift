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
    
    var appDelegate: AppDelegate
    let moc: NSManagedObjectContext
    
    var date = Date()
    var rowFromDatabase = [Any]()
    
    var arrayHabitToReturn = [[Any]]()
    var arrayHabitName = [String]()
    var arrayHabitID = [UUID]()
    
    var arrayTaskToReturn = [[Any]]()
    var arrayTaskName = [String]()
    var arrayTaskID = [UUID]()
    
    //property to return record by id
    var arrayResultByID = [Any]()
    
    init() {
        appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        moc = appDelegate.persistentContainer.viewContext
    }
    
    //insert new record in database
    func createNewHabit(name: String, category: String, cDate: Date, isReminder: Bool,reminder: Date, weekDays: String) {
        
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
    
    //fetch habit record from database
    func fetchHabitsFromDatabase() -> Array<Any> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        //filter data with category habit
        request.predicate = NSPredicate(format: "category = %@", "habit")
        do {
            let fetchData = try moc.fetch(request)
            for data in fetchData as! [NSManagedObject] {
                arrayHabitName.append(data.value(forKey: "name") as! String)
                arrayHabitID.append(data.value(forKey: "id") as! UUID)
            }
            
            arrayHabitToReturn.append(arrayHabitName)
            arrayHabitToReturn.append(arrayHabitID)
        } catch {
            print("Error while fetching data..")
        }
        
        return arrayHabitToReturn
    }
    
    //fetch task record from database
    func fetchTasksFromDatabase() -> Array<Any> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        //filter data with category task
        request.predicate = NSPredicate(format: "category = %@", "task")
        do {
            let fetchData = try moc.fetch(request)
            for data in fetchData as! [NSManagedObject] {
                arrayTaskName.append(data.value(forKey: "name") as! String)
                arrayTaskID.append(data.value(forKey: "id") as! UUID)
            }
            
            arrayTaskToReturn.append(arrayTaskName)
            arrayTaskToReturn.append(arrayTaskID)
        } catch {
            print("Error while fetching data..")
        }
        
        return arrayTaskToReturn
    }
    
    func deleteHabit(uuid: UUID) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        request.predicate = NSPredicate(format: "id = %@", "\(uuid)")
        do {
            let fetchData = try moc.fetch(request)
            let dataToDelete = fetchData[0] as! NSManagedObject
            moc.delete(dataToDelete)
            do {
                try moc.save()
                print("deleted")
            } catch {
                print(error)
            }
        } catch {
            print("Error while deleting data..")
        }
    }
    
    //fetch habit record from database
    func fetchRecordByID(uuid: UUID) -> Array<Any> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        request.fetchLimit = 1
        //filter data with category habit
        request.predicate = NSPredicate(format: "id = %@", "\(uuid)")
        do {
            let fetchData = try moc.fetch(request)
            for data in fetchData as! [NSManagedObject] {
                arrayResultByID.append(data.value(forKey: "name") as! String)
                arrayResultByID.append(data.value(forKey: "category") as! String)
                arrayResultByID.append(data.value(forKey: "isReminder") as! Bool)
                arrayResultByID.append(data.value(forKey: "reminderTime") as! Date)
                arrayResultByID.append(data.value(forKey: "weekDays") as! String)
                arrayResultByID.append(data.value(forKey: "id") as! UUID)
            }
            
        } catch {
            print("Error while fetching data..")
        }
        
        return arrayResultByID
    }
    
    func updateHabitRecord(uuid: UUID, name: String, category: String, isReminder: Bool, remTime: Date, weekDays: String) {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Habits")
        //update record where id is uuid
        request.predicate = NSPredicate(format: "id = %@", "\(uuid)")
        do {
            let fetchData = try moc.fetch(request)
            let objectToUpdate = fetchData[0] as! NSManagedObject
            objectToUpdate.setValue(name, forKey: "name")
            objectToUpdate.setValue(category, forKey: "category")
            objectToUpdate.setValue(isReminder, forKey: "isReminder")
            objectToUpdate.setValue(remTime, forKey: "reminderTime")
            objectToUpdate.setValue(weekDays, forKey: "weekDays")
            do {
                try moc.save()
            } catch {
              print(error)
            }
        } catch {
            print("Error while updating data..")
        }
    }
    
}
