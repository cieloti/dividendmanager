//
//  YahooAPI.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation

class YahooAPI {
    func getData(ticker:String, number:String) -> Stock {
        var presentValue = 0.0
        var dividend = 0.0
        var dividendRatio = ""
        var volume = ""
        var per = 0.0
        var exdividend = ""
        var currency = "KRW"
        let num = Int(number) ?? 0
        
        return Stock(ticker: ticker, price: presentValue, dividend: 0.0, period: "", number: num, volume: "", per: 0.0, exdividend: "", currency: currency)
    }
    
    func getDividendData(ticker:String) -> [DividendData] {
        var dividendData = [DividendData]()
        let month  = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "Octorber", "November", "Deccember"]
        var index = -1
        var temp = 0.0
        
        let start = Int(Date().addingTimeInterval(-31536000).timeIntervalSince1970)
        let end = Int(Date().timeIntervalSince1970)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        let semaphore = DispatchSemaphore(value: 0)
        
        if let url = URL(string: "https://query1.finance.yahoo.com/v8/finance/chart/\(ticker)?symbol=\(ticker)&period1=\(start)&period2=\(end)&interval=1d&includePrePost=true&events=div%2Csplit") {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let chart = json["chart"] as? [String:Any] {
                            if let result = chart["result"] as? Array<[String:Any]> {
                                if let events = result[0]["events"] as? [String:Any] {
                                    if let dividends = events["dividends"] as? [String:Any] {
                                        for (key, value) in dividends {
                                            let date = Date(timeIntervalSince1970: Double(key) as! TimeInterval)
                                            let monthString = dateFormatter.string(from: date)
                                            if let i:Int = month.firstIndex(of: monthString) {
                                                index = i
                                            } else {
                                                index = -1
                                            }
                                            
                                            if let amount = dividends[key] as? [String:Any] {
                                                if let temp = amount["amount"] as? Double {
                                                    if index != -1 {
                                                        dividendData.append(DividendData(month: index, dividend: temp))
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                semaphore.signal()
            }).resume()
        }
        semaphore.wait()

        return dividendData
    }
}
