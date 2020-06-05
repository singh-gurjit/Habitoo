//
//  CompleteDatabaseUtil.swift
//  Habitoo
//
//  Created by Gurjit Singh on 30/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class CompleteDatabaseUtil: ObservableObject {
    
    var appDelegate: AppDelegate
    let moc: NSManagedObjectContext
    @Published var arrayTaskIDCompleted = [Any]()
    @Published var arrayTaskUUIDCompleted = [Any]()
    @Published var arrayTaskDateCompleted = [Any]()
    @Published var arrayTaskCompletedToReturn = [[Any]]()
    
    //complete habits properties
    @Published var arrayHabitIDCompleted = [Any]()
    @Published var arrayHabitUUIDCompleted = [Any]()
    @Published var arrayHabitDateCompleted = [Any]()
    @Published var arrayHabitCompletedToReturn = [[Any]]()
    
    init() {
        appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        moc = appDelegate.persistentContainer.viewContext
    }
    
    //insert completed habit record in database
    func insertCompletedHabit (habitName: String, uuid: UUID, cDate: Date) {
        
        let habitEntity = NSEntityDescription.entity(forEntityName: "HabitCompleted", in: moc)!
        let habit = NSManagedObject(entity: habitEntity, insertInto: moc)
        
        //insert data
        habit.setValue(UUID(), forKey: "id")
        habit.setValue(uuid, forKey: "habitID")
        habit.setValue(habitName, forKey: "habitName")
        habit.setValue(cDate, forKey: "createdDate")
        
        do {
            try moc.save()
            print("Saved..")
        } catch let error as NSError {
            print("Error while inserting.. \(error.userInfo)")
        }
        
    }
    
    //insert new task record in database
    func insertCompletedTask (uuid: UUID, cDate: Date) {
        
        let habitEntity = NSEntityDescription.entity(forEntityName: "TaskCompleted", in: moc)!
        let habit = NSManagedObject(entity: habitEntity, insertInto: moc)
        
        //insert data
        habit.setValue(UUID(), forKey: "id")
        habit.setValue(uuid, forKey: "taskID")
        habit.setValue(cDate, forKey: "createdDate")
        
        do {
            try moc.save()
            print("Saved..")
        } catch let error as NSError {
            print("Error while inserting.. \(error.userInfo)")
        }
        
    }
    
    //delete habit completed record
    func deleteHabitCompleted(id: UUID) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
        request.predicate = NSPredicate(format: "id = %@", "\(id)")
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
    
    //delete task completed record
    func deleteTaskCompleted(id: UUID) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCompleted")
        request.predicate = NSPredicate(format: "id = %@", "\(id)")
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
    
    //fetch task record from database
    func fetchCompletedTasks() -> Array<Any> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCompleted")
        
        do {
            let fetchData = try moc.fetch(request)
            for data in fetchData as! [NSManagedObject] {
                arrayTaskIDCompleted.append(data.value(forKey: "id") as! UUID)
                arrayTaskUUIDCompleted.append(data.value(forKey: "taskID") as! UUID)
                arrayTaskDateCompleted.append(data.value(forKey: "createdDate") as! Date)
            }
            
            arrayTaskCompletedToReturn.append(arrayTaskIDCompleted)
            arrayTaskCompletedToReturn.append(arrayTaskUUIDCompleted)
            arrayTaskCompletedToReturn.append(arrayTaskDateCompleted)
        } catch {
            print("Error while fetching data..")
        }
        
        return arrayTaskCompletedToReturn
    }
    
    //fetch task record from database
    func fetchCompletedHabits() -> Array<Any> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
        
        do {
            let fetchData = try moc.fetch(request)
            for data in fetchData as! [NSManagedObject] {
                arrayHabitIDCompleted.append(data.value(forKey: "id") as! UUID)
                arrayHabitUUIDCompleted.append(data.value(forKey: "habitID") as! UUID)
                arrayHabitDateCompleted.append(data.value(forKey: "createdDate") as! Date)
            }
            
            arrayHabitCompletedToReturn.append(arrayHabitIDCompleted)
            arrayHabitCompletedToReturn.append(arrayHabitUUIDCompleted)
            arrayHabitCompletedToReturn.append(arrayHabitDateCompleted)
        } catch {
            print("Error while fetching data..")
        }
        return arrayHabitCompletedToReturn
    }
    
}
