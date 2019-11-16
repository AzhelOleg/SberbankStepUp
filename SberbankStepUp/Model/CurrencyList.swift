//
//  CurrencyList.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public struct CurrencyList {
    
    public var date: String
    public var previousDate: String
    public var list: [Currency] = []
    
    
    init(dto: CurrencyListDTO) {
        date = dto.Date ?? ""
        previousDate = dto.PreviousDate ?? ""
        for currencyDTO in dto.Valute {
            list.append(Currency(dto: currencyDTO.value))
        }
    }
    
    init() {
        date = ""
        previousDate = ""
    }
    
}
