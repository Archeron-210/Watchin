//
//  CoreDataStack.swift
//  Watchin
//
//  Created by Archeron on 16/02/2022.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var viewContext: NSManagedObjectContext { get }
}

class CoreDataStack: CoreDataStackProtocol {

    // MARK: - Singleton

    static let shared = CoreDataStack()

    // MARK: - Public

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Private

    private init() {}

    private static let modelName = "Watchin"

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo) for : \(storeDescription.description)")
            }
        }
        return container
    }()
}
