//
//  DataBase.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class DataBase {
    
    public static let shared = DataBase()
    
    private init() { }
    
    // =
    
    private var userList: [User] {
        get {
            var userList: [User] = []
            
            userList.append(User(name: "Олег"))
            userList.append(User(name: "Вадим"))
            
            return userList
        }
    }
    
    // =
    
    public func getUserList() -> [User] {
        return userList
    }
    
}



// MARK: - NSCopying
extension DataBase: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
