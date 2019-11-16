//
//  CurrencyDTO.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

public struct CurrencyDTO: Decodable {
    
    public var CharCode: String?
    public var Name: String?
    public var Value: Double?
    public var Previous: Double?
    
}
