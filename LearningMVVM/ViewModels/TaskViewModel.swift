//
//  TaskViewModel.swift
//  LearningMVVM
//
//  Created by Lucas Emiliano Benitez Joncic on 30/09/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(taskDescription: "Comprar pan", isCompleted: false),
        Task(taskDescription: "Tomar un descanso", isCompleted: true),
        Task(taskDescription: "Terminar el objetivo", isCompleted: false)
    ]
    
    func addTask(description: String) {
        let newTask = Task(taskDescription: description, isCompleted: false)
        tasks.append(newTask)
    }
    
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

