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
    
    private func currencySegmentRequest() -> URLRequest {
        let url = URL(string: "https://api.exchangeratesapi.io/latest?symbols=USD,EUR,CNY&base=RUB")!
        return URLRequest(url: url)
    }
    
    public func updateCurrencySegment() {
        let session = URLSession.shared
        let getListTask = session.dataTask(with: currencySegmentRequest()) { (data, response, error) in
            do {
                let list = try JSONDecoder().decode(CurrencyListDTO.self, from: data!)
                let currencyList = CurrencyList(dto: list)
                self.delegate.updateCurrencyList(with: [currencyList])
            }
            catch {
                print(error)
            }
        }
        getListTask.resume()
    }
    
}



// MARK: - NSCopying
extension ECB: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
