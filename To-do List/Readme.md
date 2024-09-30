---

## Documentación del Proyecto: **To-Do List con MVVM y SwiftData**

### Descripción General

Este proyecto es una **To-Do List** que utiliza el patrón **MVVM** junto con **SwiftUI** y **SwiftData** para manejar la persistencia de datos. La aplicación permite a los usuarios agregar, visualizar y completar tareas, reflejando los cambios de manera reactiva en la interfaz de usuario.

### Objetivos del Proyecto

- Demostrar la implementación del patrón **MVVM** (Model-View-ViewModel).
- Utilizar **SwiftData** para manejar la persistencia de datos de manera eficiente.
- Implementar una interfaz reactiva con **SwiftUI** para una experiencia fluida.

---

## Patrón MVVM

El patrón **MVVM** se estructura en tres componentes principales:

1. **Modelo (Model)**:
    - Representa las entidades de datos que queremos persistir y manipular en la aplicación. En este caso, la entidad `Task` representa una tarea con una descripción y un estado de completado.
2. **Vista (View)**:
    - Representa la interfaz de usuario y se construye con **SwiftUI**. Es responsable de mostrar los datos provenientes del ViewModel y de reflejar las acciones del usuario.
3. **ViewModel**:
    - Es el intermediario entre el modelo y la vista. En este caso, maneja la lógica de agregar tareas, cambiar el estado de completado y actualizar la interfaz en consecuencia.

---

## Implementación

### Modelo: `Task`

El modelo `Task` es una clase que representa cada tarea de la lista.

```swift
import SwiftData

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

```

- **`@Model`**: Hace que `Task` sea una entidad persistente en SwiftData.
- **Propiedades**:
    - `taskDescription`: Describe la tarea.
    - `isCompleted`: Indica si la tarea ha sido completada o no.
    - `id`: Un identificador único para cada tarea.

### Vista: `ContentView`

La vista principal de la aplicación muestra la lista de tareas y permite al usuario agregar nuevas tareas.

```swift
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\\.modelContext) private var modelContext
    @Query(sort: \\.taskDescription, order: .forward) private var tasks: [Task]
    @State private var newTaskDescription = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.taskDescription)
                                .strikethrough(task.isCompleted, color: .black)
                            Spacer()
                            Button(action: {
                                task.isCompleted.toggle()
                                try? modelContext.save()
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .red)
                            }
                        }
                    }
                }

                HStack {
                    TextField("New task", text: $newTaskDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {
                        Text("Add")
                    }
                    .padding(.leading, 8)
                }
                .padding()
            }
            .navigationTitle("To-Do List")
        }
        .modelContainer(for: Task.self)
    }

    private func addTask() {
        guard !newTaskDescription.isEmpty else { return }
        let newTask = Task(taskDescription: newTaskDescription)
        modelContext.insert(newTask)
        try? modelContext.save()
        newTaskDescription = ""
    }
}

```

- **`@Query`**: Se utiliza para obtener y ordenar las tareas de manera reactiva.
- **Acciones**:
    - Los usuarios pueden marcar tareas como completadas y agregar nuevas tareas.
    - Las tareas se actualizan en tiempo real gracias a la reactividad de SwiftUI y SwiftData.

### Configuración de la App: `LearningMVVMApp.swift`

```swift
import SwiftUI
import SwiftData

@main
struct LearningMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Task.self])
        }
    }
}

```

- **`modelContainer(for:)`**: Aquí se inicializa el contenedor de datos para la entidad `Task` de forma automática, sin necesidad de configuraciones adicionales complejas.

---

## Uso de SwiftData

**SwiftData** es un nuevo framework de persistencia que simplifica el manejo de datos. En este proyecto, se utiliza para almacenar las tareas en un contenedor persistente de manera automática. SwiftData permite que los modelos sean persistentes usando la anotación `@Model`, lo que facilita su integración en la aplicación con minimalismo y reactividad.

### ¿Por qué usar SwiftData?

1. **Persistencia Sencilla**: Con `@Model`, puedes definir tus entidades de datos fácilmente sin la necesidad de configuraciones extensas.
2. **Reactividad**: A través de `@Query` y `@Environment(\\.modelContext)`, los datos se actualizan automáticamente en la vista cuando hay cambios en el modelo.
3. **Facilidad de Configuración**: En vez de configurar un `Core Data` stack manualmente, SwiftData te permite utilizar un contenedor de modelo en pocas líneas de código.

### Paso a paso de la implementación con SwiftData:

1. **Definir el modelo persistente** usando la anotación `@Model` para la entidad `Task`.
2. **Utilizar `@Query`** en la vista para observar automáticamente los cambios en los datos persistentes.
3. **Insertar y guardar datos** en el contexto de datos (`modelContext`) cada vez que el usuario agrega o modifica una tarea.
4. **Configurar `modelContainer`** para la entidad `Task` en el archivo principal de la aplicación.

---
