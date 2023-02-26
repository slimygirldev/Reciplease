//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 16/01/2023.
//

import Foundation
import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()

    private let persistentContainerName: String = "Reciplease"

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }

    var isTesting: Bool = false

    private init(_ isTesting: Bool = false) {
        self.isTesting = isTesting
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        if isTesting {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false
            let container = NSPersistentContainer(name: persistentContainerName)
            container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        } else {
            let container = NSPersistentContainer(name: persistentContainerName)
            container.loadPersistentStores { storeDescription, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
                }
            }
            return container}
    }()

    lazy var managedContext: NSManagedObjectContext = persistentContainer.viewContext

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
