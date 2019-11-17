//
//  User.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

public struct User {
    
    public var name: String
    public var login: String
    public var password: String
    
    init(name: String, password: String = "123") {
        self.name = name
        self.login = name
        self.password = password
    }
    
}
