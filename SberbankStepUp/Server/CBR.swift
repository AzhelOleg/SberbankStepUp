//
//  CBR.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class CBR {
    
    public static let shared = CBR()
    
    private init() { }
    
    // =
    
    var delegate: CurrencyListUpdate?
    private var currencyList = CurrencyList()
    
    // =
    
    private func currencyRequest() -> URLRequest {
        let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js")!
        return URLRequest(url: url)
    }
    
    public func updateCurrencyList() {
        let session = URLSession.shared
        let getListTask = session.dataTask(with: currencyRequest()) { (data, response, error) in
            do {
                let list = try JSONDecoder().decode(CurrencyListDTO.self, from: data!)
                let currencyList = CurrencyList(dto: list)
                self.delegate?.updateCurrencyList(with: currencyList)
            }
            catch {
                print(error)
            }
        }
        getListTask.resume()
    }
    
}



// MARK: - NSCopying
extension CBR: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
