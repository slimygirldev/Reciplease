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

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        return container
    }()
}
