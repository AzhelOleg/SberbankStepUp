//
//  Date.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

extension Date {
    
    public static func segment() -> [String] {
        var segment: [String] = []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for i in 0...11 {
            let earlyDate = Calendar.current.date(byAdding: .month, value: -i, to: Date())
            if let date = earlyDate {
                segment.append(formatter.string(from: date))
            }
        }
        
        return segment
    }
    
}
