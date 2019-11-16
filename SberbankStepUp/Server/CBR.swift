//
//  CBR.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class CBR {
    
    public static let shared = CBR()
    
    private init() { }
    
    // =
    
}



// MARK: - NSCopying
extension CBR: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
