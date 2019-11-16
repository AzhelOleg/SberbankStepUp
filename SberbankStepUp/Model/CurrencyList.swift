//
//  CurrencyList.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public struct CurrencyList {
    
    public var date: Date
    public var previousDate: Date
    public var list: [Currency] = []
    
    
    init(dto: CurrencyListDTO) {
        date = dto.Date ?? Date.init()
        previousDate = dto.PreviousDate ?? Date.init()
        for currencyDTO in dto.Valute {
            list.append(Currency(dto: currencyDTO.value))
        }
    }
    
    init() {
        date = Date.init()
        previousDate = Date.init()
    }
    
}
