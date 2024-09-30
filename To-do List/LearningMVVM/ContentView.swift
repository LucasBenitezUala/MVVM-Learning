//
//  ContentView.swift
//  LearningMVVM
//
//  Created by Lucas Emiliano Benitez Joncic on 30/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.taskDescription, order: .forward) private var tasks: [Task]  // Asegúrate de tener una consulta ordenada
    @State private var newTaskDescription = ""  // Estado para capturar la nueva tarea

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in  // Muestra las tareas
                        HStack {
                            Text(task.taskDescription)
                                .strikethrough(task.isCompleted, color: .black)
                            Spacer()
                            Button(action: {
                                task.isCompleted.toggle()
                                try? modelContext.save()  // Guarda el cambio de estado
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .red)
                            }
                        }
                    }
                }

                HStack {
                    TextField("New task", text: $newTaskDescription)  // Campo de entrada para una nueva tarea
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {  // Botón para añadir la nueva tarea
                        Text("Add")
                    }
                    .padding(.leading, 8)
                }
                .padding()
            }
            .navigationTitle("To-Do List")
        }
        .modelContainer(for: Task.self)  // Configura el contenedor del modelo
    }
    
    // Función para añadir una nueva tarea
    private func addTask() {
        guard !newTaskDescription.isEmpty else { return }
        let newTask = Task(taskDescription: newTaskDescription)
        modelContext.insert(newTask)  // Inserta la nueva tarea en el contexto
        try? modelContext.save()  // Guarda los cambios en la base de datos
        newTaskDescription = ""  // Limpia el campo de texto
    }
}

#Preview {
    ContentView()
}
