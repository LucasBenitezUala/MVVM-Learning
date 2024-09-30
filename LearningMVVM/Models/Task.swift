//
//  Task.swift
//  LearningMVVM
//
//  Created by Lucas Emiliano Benitez Joncic on 30/09/2024.
//

import SwiftData
import Foundation

@Model
class Task {
    var id: UUID
    var taskDescription: String
    var isCompleted: Bool

    init(taskDescription: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
    }
}

