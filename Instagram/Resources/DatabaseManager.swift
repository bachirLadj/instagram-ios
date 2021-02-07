//
//  DatabaseManager.swift
//  Instagram
//
//  Created by yassir on 01/02/2021.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    /// check if username and email is available
    public func canCreateNewUser(with email: String, username: String, Completion: (Bool) -> Void) {
        Completion(true)
    }
    
    /// inserts new user data to database
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // successed
                completion(true)
                return
            }
            else {
                // failed
                completion(false)
                return
            }
        }
    }
}
