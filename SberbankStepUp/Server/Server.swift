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
    
    private let delegate = CurrencyManager.shared
    
    // =
    
    public func userList() -> [User] {
        return DataBase.shared.getUserList()
    }
    
    public func updateCurrencySegment() {
        ECB.shared.updateCurrencySegment()
    }
    
}



// MARK: - CBRDelegate
extension Server: CurrencySegmentUpdate {
    
    func updateCurrencySegment(with list: CurrencyList) {
        delegate.updateCurrencySegment(with: list)
    }
    
}



// MARK: - NSCopying
extension Server: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
