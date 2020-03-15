
//
//  WebService.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/01.
//  Copyright © 2020 cieloti. All rights reserved.
//
import Foundation
import SwiftSoup

class WebService {
    func getCurrency(from: String, to: String) -> Double {
        var ret = 0.0

        let semaphore = DispatchSemaphore(value: 0)
        if let url = URL(string:"https://api.exchangeratesapi.io/latest?base=\(from)") {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(Currency.self, from: data)
                        ret = self.getLocaleCurrency(locale: to, parsedJSON: parsedJSON)
                        semaphore.signal()
                    } catch {
                        print(error)
                        semaphore.signal()
                    }
                }
                }).resume()
        }
        semaphore.wait(timeout: .now() + 3)
        
        return ret
    }
    
    func getLocaleCurrency(locale: String, parsedJSON: Currency) -> Double {
        switch(locale) {
        case "KRW":
            return parsedJSON.rates.KRW
        case "USD":
            return parsedJSON.rates.USD
        case "HKD":
            return parsedJSON.rates.HKD
        case "CNY":
            return parsedJSON.rates.CNY
        case "JPY":
            return parsedJSON.rates.JPY
        default:
            return 0.0
        }
    }
    
    func getCurrencyLocale() -> [String: Double] {
        var ret: [String : Double] = [:]

        let semaphore = DispatchSemaphore(value: 0)
        if let url = URL(string:"https://api.exchangeratesapi.io/latest?base=KRW") {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(Currency.self, from: data)
                        ret["USD"] = 1.0 / parsedJSON.rates.USD
                        ret["KRW"] = parsedJSON.rates.KRW
                        ret["HKD"] = 1.0 / parsedJSON.rates.HKD
                        ret["CNY"]  = 1.0 / parsedJSON.rates.CNY
                        ret["JPY"]  = 1.0 / parsedJSON.rates.JPY
                        semaphore.signal()
                    } catch {
                        print(error)
                        semaphore.signal()
                    }
                }
                }).resume()
        }
        semaphore.wait(timeout: .now() + 3)
        
        return ret
    }
}
