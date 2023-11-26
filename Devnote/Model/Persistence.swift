//
//  Persistence.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  //MARK: - 1.PERSISTET CONTROLLER

  //MARK: - 2.PERSISTENT CONTAINER
  let container: NSPersistentContainer
  //MARK: - 3.INITIALIZATION (Load the persistent store)
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Devnote")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }

  //MARK: - 4. PREVIEW
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for i in 0..<5 {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = "sample task no\(i)"
      newItem.completion = false
      newItem.id = UUID()

    }
    do {
      try viewContext.save()
    } catch {

      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
