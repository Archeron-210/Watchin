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

    // MARK: - Properties

    static let shared = CoreDataStack()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private static let modelName = "Watchin"

    // MARK: - Private

    private init() {}
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
