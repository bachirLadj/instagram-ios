//
//  AuthManager.swift
//  Instagram
//
//  Created by yassir on 01/02/2021.
//
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // Mark :- Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool)  -> Void) {
        // check if username and email is available
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account Database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else{
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // username or email does not exist
                completion(false)
            }
            
        }
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if let email = email {
            // email log In
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            // username log In
            
            print(username)
            
        }
    }
    
}

