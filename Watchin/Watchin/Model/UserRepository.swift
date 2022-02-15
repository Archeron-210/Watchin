//
//  UserRepository.swift
//  Watchin
//
//  Created by Archeron on 15/02/2022.
//

import Foundation

struct User {
    var name: String
    var profilePictureData: Data?
}

protocol UserRepositoryProtocol: AnyObject {
    // Retrieve the user
    func getUser() -> User

    // Save given user. Returns true if succeeded, false if failed.
    func saveUser(_ user: User) -> Bool
}

class UserRepository: UserRepositoryProtocol {

    static let shared: UserRepositoryProtocol = UserRepository()

    private enum Keys {
        static let name = "name"
        static let fileName = "profile_picture.png"
    }

    private lazy var user: User = {
        let name = self.getName()
        let profilePictureData = self.getProfilePicture()

        return User(name: name, profilePictureData: profilePictureData)
    }()

    // MARK: - Init

    private init() {}

    // MARK: - UserRepository

    func getUser() -> User {
        return self.user
    }

    func saveUser(_ user: User) -> Bool {
        // Try to save the profile picture
        let didSaveProfilePicture = self.saveProfilePicture(imageData: user.profilePictureData)

        // If it failed, save failed so we return false.
        guard didSaveProfilePicture else {
            return false
        }

        // Save the user name
        self.saveName(name: user.name)

        // Update the user in memory
        self.user = user

        // Save succeded.
        return true
    }

    // MARK: - Private helpers

    private func saveName(name: String) {
        UserDefaults.standard.set(name, forKey: Keys.name)
    }

    private func getName() -> String {
        return UserDefaults.standard.string(forKey: Keys.name) ?? "Name"
    }

    private func saveProfilePicture(imageData: Data?) -> Bool {
        guard let data = imageData else {
            return false
        }
        // Create URL
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let documentsUrl = documents else {
            return false
        }
        let url = documentsUrl.appendingPathComponent(Keys.fileName)
        do {
            // Write to Disk
            try data.write(to: url)
            return true
        } catch {
            print("Unable to write data to disk (\(error))")
            return false
        }
    }

    private func getProfilePicture() -> Data? {
        // Create URL
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let documentsUrl = documents else {
            return nil
        }
        let url = documentsUrl.appendingPathComponent(Keys.fileName)
        do {
            // Read from Disk
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Unable to read data from disk (\(error))")
            return nil
        }
    }
}










    // MARK: - Properties
//
//    private let coreDataStack: CoreDataStackProtocol
//
//    // MARK: - Init
//
//    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared) {
//        self.coreDataStack = coreDataStack
//    }
//
//    // MARK: - Functions
//
//    func getUser() -> User {
//        let request: NSFetchRequest<User> = User.fetchRequest()
//        do {
//            let user = try coreDataStack.viewContext.fetch(request)
//            return user
//        } catch {
//            return
//        }
//    }
//
//    func saveUserInfo(name: String, profilePicture: Data) {
//        let user = User(context: coreDataStack.viewContext)
//
//        user.name = name
//        user.profilePicture = profilePicture
//
//        do {
//            try coreDataStack.viewContext.save()
//        } catch {
//            print("Unexpected error, we were unable to save changes")
//        }
//
//    }

