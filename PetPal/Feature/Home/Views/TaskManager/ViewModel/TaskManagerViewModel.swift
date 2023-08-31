//
//  TaskManagerViewModel.swift
//  PetPal
//
//  Created by Andrew on 27.05.2023.
//

import SwiftUI
import CoreData

class TaskManagerViewModel: ObservableObject {
    @Published var curentTab: String = "Today"
    
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    func addTask(context: NSManagedObjectContext) -> Bool{
        let task = Task(context: context)
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save(){
            return true
        }
        return false 
    }
    
    func resetTaskData() {
        taskType = "Basic"
        taskColor = "yellowMain"
        taskTitle = ""
        taskDeadline = Date()
        
    }
}

