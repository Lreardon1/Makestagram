//
//  User.swift
//  Makestagram
//
//  Created by Leith Reardon on 7/10/18.
//  Copyright © 2018 Leith Reardon. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {
    let uid: String
    let username: String
    
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError()
        }
        
        return currentUser
    }
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
        let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
    }
    
    static func setCurrentUser(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        _current = user
        
    }
}
