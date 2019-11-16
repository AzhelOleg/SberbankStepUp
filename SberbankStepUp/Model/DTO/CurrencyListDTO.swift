//
//  CurrencyListDTO.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public struct CurrencyListDTO: Decodable {
    
    public var Date: String?
    public var PreviousDate: String?
    public var Valute: [String: CurrencyDTO]
    
}
