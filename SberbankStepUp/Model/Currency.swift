//
//  Currency.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

public struct Currency {
    
    public var code: String
    public var name: String
    public var value: Double
    public var previousValue: Double
    
    
    init(dto: CurrencyDTO) {
        code = dto.CharCode ?? ""
        name = dto.Name ?? ""
        value = dto.Value ?? 0
        previousValue = dto.Previous ?? 0
    }
    
}
