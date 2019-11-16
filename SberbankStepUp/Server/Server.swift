//
//  Server.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class Server {
    
    public static let shared = Server()
    
    private init() { }
    
    // =
    
}



// MARK: - NSCopying
extension Server: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
