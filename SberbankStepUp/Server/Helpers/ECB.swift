//
//  ECB.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class ECB {
    
    public static let shared = ECB()
    
    private init() { }
    
    // =
    
    private let delegate = Server.shared
    
    // =
    
    private func currencyListRequest(for date: String) -> URLRequest {
        let url = URL(string: "https://api.exchangeratesapi.io/\(date)?symbols=USD,EUR,CNY&base=RUB")!
        return URLRequest(url: url)
    }
    
    public func updateCurrencySegment() {
        let dateSegment = Date.segment()
        let session = URLSession.shared
        
        var index = 0
        for date in dateSegment {
            let i = index
            index += 1
            let getListTask = session.dataTask(with: self.currencyListRequest(for: date)) { (data, response, error) in
                do {
                    let list = try JSONDecoder().decode(CurrencyListDTO.self, from: data!)
                    var currencyList = CurrencyList(dto: list)
                    currencyList.id = i
                    self.delegate.updateCurrencySegment(with: currencyList)
                }
                catch {
                    print(error)
                }
            }
            getListTask.resume()
        }
    }
    
}



// MARK: - NSCopying
extension ECB: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
