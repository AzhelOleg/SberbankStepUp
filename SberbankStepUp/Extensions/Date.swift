//
//  Date.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Date formatters
    private static func currencyDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    private static func currencyDateFormatterYear() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    private static func currencyDateFormatterMonth() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    // =
    
    public static func segment() -> [String] {
        var segment: [String] = []
        
        for i in 0...11 {
            let earlyDate = Calendar.current.date(byAdding: .month, value: -i, to: Date())
            if let date = earlyDate {
                segment.append(currencyDateFormatter().string(from: date))
            }
        }
        
        return segment
    }
    
    public static func currencyListDate(from string: String) -> Date? {
        return currencyDateFormatter().date(from: string)
    }
    
    public static func currencyListDateYear(from date: Date) -> String {
        return currencyDateFormatterYear().string(from: date)
    }
    
    public static func currencyListDateMonth(from date: Date) -> String {
        return currencyDateFormatterMonth().string(from: date)
    }
    
}
