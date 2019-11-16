//
//  CurrencyList.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

public struct CurrencyList {
    
    public var base: String
    public var date: String
    public var rates: [String: Double] = [:]
    
    
    init(dto: CurrencyListDTO) {
        base = dto.base ?? ""
        date = dto.date ?? ""
        rates = dto.rates ?? [:]
    }
    
    init() {
        base = ""
        date = ""
    }
    
}
