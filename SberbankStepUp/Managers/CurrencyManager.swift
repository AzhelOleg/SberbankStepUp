//
//  CurrencyManager.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class CurrencyManager {
    
    public static let shared = CurrencyManager()
    
    private init() { }
    
    // =
    
    private var currencySegment: [CurrencyList] = []
    
    // =
    
    public func updateCurrencySegment() {
        Server.shared.updateCurrencySegment()
    }
    
}



// MARK: - CBRDelegate
extension CurrencyManager: CurrencySegmentUpdate {
    
    func updateCurrencySegment(with list: CurrencyList) {
        currencySegment.append(list)
    }
    
}



// MARK: - NSCopying
extension CurrencyManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
