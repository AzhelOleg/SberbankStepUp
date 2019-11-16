//
//  AnalyticStruct.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

public enum AnaliticConclusion {
    case rise
    case stability
    case drop
}



// MARK: - Struct
public struct AnalyticStruct {
    
    public var year: String = ""
    public var month: String = ""
    public var money: Float = 0.0
    public var currency: String = ""
    public var difference: Float = 0.0
    public var conclusion: AnaliticConclusion = .stability
    
}
