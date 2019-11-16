//
//  CurrencyManager.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public enum Currency: String {
    case RUB
    case USD
    case EUR
    case CNY
}



// MARK: - Class
public final class CurrencyManager {
    
    public static let shared = CurrencyManager()
    
    private init() { }
    
    // =
    
    private var currencySegment: [CurrencyList] = []
    
    // =
    
    public func updateCurrencySegment() {
        Server.shared.updateCurrencySegment()
    }
    
    public func getAnalyticSegmentList(for money: Float, currency: Currency) -> [AnalyticStruct] {
        var analyticSegmentList: [AnalyticStruct] = []
        
        var index = 0
        for currencyList in currencySegment {
            var analyticStruct = AnalyticStruct()
            // date
            let date = Date.currencyListDate(from: currencyList.date)
            if let _date = date {
                analyticStruct.year = Date.currencyListDateYear(from: _date)
                analyticStruct.month = Date.currencyListDateMonth(from: _date)
            }
            // money
            let currencyRate = currencyList.rates[currency.rawValue]
            if let _currencyRate = currencyRate {
                analyticStruct.money = Float(Double(money) / _currencyRate)
            }
            analyticStruct.currency = currency.rawValue
            // difference
            if index != 0 {
                let earlyAnalyticStruct = analyticSegmentList[index]
                
                if earlyAnalyticStruct.money > analyticStruct.money {
                    analyticSegmentList[index].conclusion = .rise
                    analyticSegmentList[index].difference = ((earlyAnalyticStruct.money - analyticStruct.money)
                                                                                    / earlyAnalyticStruct.money) * 100
                }
                else if earlyAnalyticStruct.money < analyticStruct.money {
                    analyticSegmentList[index].conclusion = .drop
                    analyticSegmentList[index].difference = ((earlyAnalyticStruct.money - analyticStruct.money)
                                                                                    / earlyAnalyticStruct.money) * 100
                }
                else { analyticSegmentList[index].conclusion = .stability }
                
                index += 1
            }
            // append
            analyticSegmentList.append(analyticStruct)
        }
        
        analyticSegmentList.reverse()
        return analyticSegmentList
    }
    
}



// MARK: - CBRDelegate
extension CurrencyManager: CurrencySegmentUpdate {
    
    func updateCurrencySegment(with list: CurrencyList) {
        currencySegment.append(list)
        currencySegment = currencySegment.sorted { $0.id < $1.id }
    }
    
}



// MARK: - NSCopying
extension CurrencyManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
