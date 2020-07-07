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
    @Published var isHabitComplete = false
    
    @Published var fetchResultForTodayID = [UUID]()
    @Published var fetchResultForTodayHabitID = [UUID]()
    @Published var fetchResultForToday = [[UUID]]()
    var date = Date()
    var collectionUtil = CollectionUtil()
    
    @Published var fetchHabitRecordForThisMonth = [Any]()
    @Published var fetchHabitCompletedDateForThisMonth = [Date]()
    @Published var fetchTaskCompletedDateForThisMonth = [Date]()
    @Published var topHabitsCount = 0
    
    @Published var topHabitsCreatedDate = Date()
    @Published var currentDate = Date()
    @Published var dayCounts = 0
    var dateFormatter = DateFormatter()
    @Published var toptaskCount = 0
    
    @Published var topTaskCreatedDate = Date()
    @Published var dayCountsTask = 0
    
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
            //print("Saved..")
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
            //print("Saved..")
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
                //print("deleted")
            } catch {
                //print(error)
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
                //print("deleted")
            } catch {
                //print(error)
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
    
    func searchCompletedHabits(hid: UUID, cDate: Date) {
           
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
           let habitid = NSPredicate(format: "habitID = %@", "\(hid)")
           let cdate = NSPredicate(format: "createdDate = %@", "\(cDate)")
           let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [habitid, cdate])
           request.predicate = andPredicate
           
           do {
               let fetchData = try moc.fetch(request)
               
            if fetchData.count > 0 {
                isHabitComplete = true
                //print("found")
            } else {
                isHabitComplete = false
                //print("not found")
            }
           } catch {
               print("Error while fetching data..")
           }
           //return isHabitComplete
       }
    
    func fetchTodaysHabits(cDate: Date) -> Array<Any> {
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
        request.predicate = NSPredicate(format: "createdDate = %@", cDate as NSDate)

        do {
            let fetchData = try moc.fetch(request)
            if fetchData.count > 0 {
                for data in fetchData as! [NSManagedObject] {
                    fetchResultForTodayHabitID.append(data.value(forKey: "habitID") as! UUID)
                    fetchResultForTodayID.append(data.value(forKey: "id") as! UUID)
                }
                fetchResultForToday.append(fetchResultForTodayHabitID)
                fetchResultForToday.append(fetchResultForTodayID)
            } else {
                //print("No record found")
            }
        } catch {
            print("Error while fetching data..")
        }
        //print("\(fetchResultForToday)")
        return fetchResultForToday
    }
    
    //fetch particular habit record for this month
    func habitRecordForThisMonth(hID: UUID) -> Array<Any> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
        request.predicate = NSPredicate(format: "habitID = %@", "\(hID)")
        fetchHabitCompletedDateForThisMonth.removeAll()
        do {
            let fetchData = try moc.fetch(request)
            if fetchData.count > 0 {
                for data in fetchData as! [NSManagedObject] {
                    fetchHabitCompletedDateForThisMonth.append(data.value(forKey: "createdDate") as! Date)
                }
            } else {
                print("No record found")
            }
        } catch {
            print("Error while fetching data..")
        }
        return fetchHabitCompletedDateForThisMonth
    }
    
    //fetch particular task record for this month
    func taskRecordForThisMonth(tID: UUID) -> Array<Any> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCompleted")
        request.predicate = NSPredicate(format: "taskID = %@", "\(tID)")

        do {
            let fetchData = try moc.fetch(request)
            if fetchData.count > 0 {
                for data in fetchData as! [NSManagedObject] {
                    fetchTaskCompletedDateForThisMonth.append(data.value(forKey: "createdDate") as! Date)
                }
            } else {
                print("No record found")
            }
        } catch {
            print("Error while fetching data..")
        }
        return fetchTaskCompletedDateForThisMonth
    }
    
    func topHabitRecordForThisMonth(hID: UUID) -> Int {
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
           request.predicate = NSPredicate(format: "habitID = %@", "\(hID)")
            topHabitsCount = 0
           do {
               let fetchData = try moc.fetch(request)
               if fetchData.count > 0 {
                   for _ in fetchData as! [NSManagedObject] {
                       topHabitsCount += 1
                   }
                //print("\(hID) - \(topHabitsCount)")
               } else {
                   print("No record found")
               }
           } catch {
               print("Error while fetching data..")
           }
           return topHabitsCount
       }
    
        func topHabitCreatedDaysCount(hID: UUID) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        request.predicate = NSPredicate(format: "id = %@", "\(hID)")

        do {
            let fetchData = try moc.fetch(request)
            let data = fetchData[0] as! NSManagedObject
            topHabitsCreatedDate = data.value(forKey: "createdDate") as! Date
            let calendar = Calendar.current

            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: topHabitsCreatedDate)
            let date2 = calendar.startOfDay(for: currentDate)

            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            dayCounts = components.day ?? 0
        } catch {
            print("Error while fetching data..")
        }
        return dayCounts
    }
    
    func topTasksRecordForThisMonth(tID: UUID) -> Int {
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCompleted")
           request.predicate = NSPredicate(format: "taskID = %@", "\(tID)")
           toptaskCount = 0
           do {
               let fetchData = try moc.fetch(request)
               if fetchData.count > 0 {
                   for _ in fetchData as! [NSManagedObject] {
                       toptaskCount += 1
                   }
                //print("\(hID) - \(topHabitsCount)")
               } else {
                   print("No record found")
               }
           } catch {
               print("Error while fetching data..")
           }
           return toptaskCount
       }
    
        func topTaskCreatedDaysCount(tID: UUID) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habits")
        request.predicate = NSPredicate(format: "id = %@", "\(tID)")

        do {
            let fetchData = try moc.fetch(request)
            let data = fetchData[0] as! NSManagedObject
            topTaskCreatedDate = data.value(forKey: "createdDate") as! Date
            let calendar = Calendar.current

            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: topTaskCreatedDate)
            let date2 = calendar.startOfDay(for: currentDate)

            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            dayCountsTask = components.day ?? 0
        } catch {
            print("Error while fetching data..")
        }
        return dayCountsTask
    }
    
    func calculatePercentageThisYear() -> CGFloat {
        
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HabitCompleted")
        
        topHabitsCount = 0
        
        return CGFloat(Int.random(in: 1..<10))
    }
}
