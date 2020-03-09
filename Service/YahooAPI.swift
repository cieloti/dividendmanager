//
//  YahooAPI.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/01.
//  Copyright © 2020 cieloti. All rights reserved.
//
import Foundation

class YahooAPI {
    let webService = WebService()
    let yahooData = YahooData()
    
    func getData(ticker:String, number:String) -> Stock {
        var divData: [DividendData]
        var presentValue = 0.0
        var dividend = 0.0
        var dividendRatio = ""
        var volume = ""
        var per = 0.0
        var exdividend = ""
        var longName = ""
        var currency = "KRW"
        let num = Int(number) ?? 0
        var fail = false
        
        let semaphore = DispatchSemaphore(value: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0;
        
        if let url = URL(string: "https://query1.finance.yahoo.com/v7/finance/quote?symbols=\(ticker)") {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(QuoteResponse.self, from: data)
                        if parsedJSON.quoteResponse.result.count != 0  {
                            presentValue = parsedJSON.quoteResponse.result[0].regularMarketPrice
                            let unformattedValue = parsedJSON.quoteResponse.result[0].marketCap
                            per = parsedJSON.quoteResponse.result[0].trailingPE
                            currency = parsedJSON.quoteResponse.result[0].currency
                            longName = parsedJSON.quoteResponse.result[0].longName
                            // dividendRatio = String(parsedJSON.quoteResponse.result[0].trailingAnnualDividendRate)
                            formatter.locale = Locale(identifier: self.getIdentifier(currency: currency))
                            volume = formatter.string(from: NSNumber(value: unformattedValue))!
                            let date = Date(timeIntervalSince1970: Double(parsedJSON.quoteResponse.result[0].dividendDate))
                            exdividend = dateFormatter.string(from: date)
                        }
                        semaphore.signal()
                    } catch {
                        do {
                            let parsedJSON = try jsonDecoder.decode(KNFQuoteResponse.self, from: data)
                            presentValue = parsedJSON.quoteResponse.result[0].regularMarketPrice
                            let unformattedValue = parsedJSON.quoteResponse.result[0].marketCap
                            per = parsedJSON.quoteResponse.result[0].trailingPE
                            currency = parsedJSON.quoteResponse.result[0].currency
                            longName = parsedJSON.quoteResponse.result[0].longName
                            formatter.locale = Locale(identifier: self.getIdentifier(currency: currency))
                            volume = formatter.string(from: NSNumber(value: unformattedValue))!
                        } catch {
                            print(error)
                            fail = true
                        }
                        semaphore.signal()
                    }
                }
            }).resume()
        }
        semaphore.wait(timeout: .now() + 3)
        
        if fail {
            return yahooData.getData(ticker: ticker, number: number)
        }
        
        divData = self.getDividendData(ticker: ticker)
        
        for div in divData {
            dividend += div.dividend
        }
        dividendRatio = String(format:"%.2f", dividend / presentValue * 100) + "%"
        
        return Stock(ticker: ticker, price: presentValue, dividend: dividend, period: dividendRatio, number: num, volume: volume, per: per, exdividend: exdividend, currency: currency, longName: longName)
    }
    
    func getIdentifier(currency: String) -> String {
        switch currency {
        case "USD":
            return "en_US"
        case "KRW":
            return "ko_KR"
        case "CNY":
            return "zh"
        case "HK":
            return "en_HK"
        default:
            return "ko_KR"
        }
    }
    
    func getDividendData(ticker:String) -> [DividendData] {
        var dividendData = [DividendData]()
        let month  = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        var index = -1
        var currency = "KRW"
        var krw = 0.0
        
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
                                if let meta = result[0]["meta"] as? [String:Any] {
                                    if let c = meta["currency"] as? String {
                                        currency = c
                                    }
                                }

                                if let events = result[0]["events"] as? [String:Any] {
                                    if let dividends = events["dividends"] as? [String:Any] {
                                        for (key, _) in dividends {
                                            let date = Date(timeIntervalSince1970: Double(key)!)
                                            let monthString = dateFormatter.string(from: date)
                                            if let i:Int = month.firstIndex(of: monthString) {
                                                index = i
                                            } else {
                                                index = -1
                                            }
                                            
                                            if let amount = dividends[key] as? [String:Any] {
                                                if let temp = amount["amount"] as? Double {
                                                    if index != -1 && temp > 0 {
                                                        dividendData.append(DividendData(month: index, dividend: temp, currency:currency))
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
        semaphore.wait(timeout: .now() + 3)

        return dividendData
    }
    
    func getChart(ticker:String) -> AssetDetailChartModel {
        let start = Int(Date().addingTimeInterval(-31536000).timeIntervalSince1970)
        let end = Int(Date().timeIntervalSince1970)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        var ret = AssetDetailChartModel(date: [0], price: [0.0])

        let semaphore = DispatchSemaphore(value: 0)
        // "https://query1.finance.yahoo.com/v8/finance/chart/\(ticker)?symbol=\(ticker)&period1=\(start)&period2=\(end)&interval=1d&range=1mo
        // "validRanges":[
//        "1d",
//        "5d",
//        "1mo",
//        "3mo",
//        "6mo",
//        "1y",
//        "2y",
//        "5y",
//        "10y",
//        "ytd",
//        "max"
//        ]
        if let url = URL(string: "https://query1.finance.yahoo.com/v8/finance/chart/\(ticker)?symbol=\(ticker)&interval=1d&range=1mo") {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    var formmatedTimestamp: [Int] = []
                    do {
                        let parsedJSON = try jsonDecoder.decode(ChartResponse.self, from: data)
                        let format = DateFormatter()
                        format.dateFormat = "MMdd"
                        for i in parsedJSON.chart.result[0].timestamp {
                            let formattedDate = format.string(from: Date(timeIntervalSince1970: Double(i)))
                            formmatedTimestamp.append(Int(formattedDate) ?? 0)
                        }
                        ret = AssetDetailChartModel(date: formmatedTimestamp, price: parsedJSON.chart.result[0].indicators.adjclose[0].adjclose)
                        semaphore.signal()
                    } catch {
                        print(error)
                    }
                }
            }).resume()
        }
        semaphore.wait(timeout: .now() + 3)

        return ret
    }
}
