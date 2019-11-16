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
    
    var delegate: CurrencyListUpdate?
    
    // =
    
    public func userList() -> [User] {
        return DataBase.shared.getUserList()
    }
    
    public func currencyList() {
        CBR.shared.updateCurrencyList()
    }
    
}



// MARK: - CBRDelegate
extension Server: CurrencyListUpdate {
    
    func updateCurrencyList(with list: CurrencyList) {
        delegate?.updateCurrencyList(with: list)
    }
    
}



// MARK: - NSCopying
extension Server: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
