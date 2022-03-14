//
//  UserRepository.swift
//  Watchin
//
//  Created by Archeron on 15/02/2022.
//

import Foundation

class UserRepository {

    // MARK: - Keys

    private enum Keys {
        static let name = "name"
        static let fileName = "profile_picture.png"
    }

    // MARK: - Properties
    
    static let shared = UserRepository()
    private lazy var user: User = {
        let name = self.getName()
        let profilePictureData = self.getProfilePicture()

        return User(name: name, profilePictureData: profilePictureData)
    }()

    // MARK: - Init

    private init() {}

    // MARK: - UserRepository

    func getUser() -> User {
        return user
    }

    func saveUser(_ user: User) -> Bool {
        // Tries to save the profile picture
        let didSaveProfilePicture = saveProfilePicture(imageData: user.profilePictureData)
        // If it failed, then saving failed, so returns false
        guard didSaveProfilePicture else {
            return false
        }
        // Saves the user name
        saveName(name: user.name)
        // Updates the user in memory
        self.user = user
        // Save succeded
        return true
    }

    // MARK: - Name Management

    private func saveName(name: String) {
        UserDefaults.standard.set(name, forKey: Keys.name)
    }

    private func getName() -> String {
        return UserDefaults.standard.string(forKey: Keys.name) ?? "Name"
    }

    // MARK: - Profile Picture Management

    private func saveProfilePicture(imageData: Data?) -> Bool {
        guard let data = imageData else {
            return false
        }
        // Creates URL
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let documentsUrl = documents else {
            return false
        }
        let url = documentsUrl.appendingPathComponent(Keys.fileName)
        do {
            // Writes to disk
            try data.write(to: url)
            return true
        } catch {
            print("Unable to write data to disk (\(error.localizedDescription))")
            return false
        }
    }

    private func getProfilePicture() -> Data? {
        // Creates URL
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let documentsUrl = documents else {
            return nil
        }
        let url = documentsUrl.appendingPathComponent(Keys.fileName)
        do {
            // Reads from disk
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Unable to read data from disk, or no profile picture setted yet (\(error.localizedDescription))")
            return nil
        }
    }
}
