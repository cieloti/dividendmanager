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
        let start = Int(Date().addingTimeInterval(-31536000).timeIntervalSince1970)
        let end = Int(Date().timeIntervalSince1970)

        var presentValue = 0.0
        var dividend = 0.0
        var dividendRatio = ""
        var volume = ""
        var per = 0.0
        var exdividend = ""
        var currency = "KRW"
        let num = Int(number) ?? 0

        if let url = URL(string: "https://query1.finance.yahoo.com/v8/finance/chart/\(ticker)?symbol=\(ticker)&period1=\(start)&period2=\(end)&interval=1d&includePrePost=true&events=div%2Csplit") {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(Chart.self, from: data)
                    currency = parsedJSON.chart.result[0].meta.currency
                    presentValue = parsedJSON.chart.result[0].meta.regularMarketPrice
//                    print(parsedJSON.chart.result[0].events.dividends.one.amount)
                } catch {
                    print(error)
                }
            }
            }).resume()
        }
        return Stock(ticker: ticker, price: presentValue, dividend: 0.0, period: "", number: num, volume: "", per: 0.0, exdividend: "", currency: currency)
    }
}

struct Chart: Codable {
    var chart: C1
}

struct C1: Codable {
    var result: [C2]
}

struct C2: Codable {
    var meta: Meta
    var events:Events
    var timestamp: [Int]
}

struct Meta: Codable {
    var currency: String
    var symbol: String
    var regularMarketPrice: Double
}

struct Events: Codable {
    var dividends: Dividends
}

struct Dividends: Codable {
    var one: Amount
    var two: Amount
    enum CodingKeys: String, CodingKey {
        case one  = "1573137000"
        case two = "1557495000"
    }
}

struct Amount: Codable {
    var amount: Double
    var date: Int
}

// {"chart":{"result":[{"meta":{"currency":"USD","symbol":"AAPL","exchangeName":"NMS","instrumentType":"EQUITY","firstTradeDate":345459600,"regularMarketTime":1583182801,"gmtoffset":-18000,"timezone":"EST","exchangeTimezoneName":"America/New_York","regularMarketPrice":298.81,"chartPreviousClose":273.36,"priceHint":2,"currentTradingPeriod":{"pre":{"timezone":"EST","start":1583226000,"end":1583245800,"gmtoffset":-18000},"regular":{"timezone":"EST","start":1583245800,"end":1583269200,"gmtoffset":-18000},"post":{"timezone":"EST","start":1583269200,"end":1583283600,"gmtoffset":-18000}},"dataGranularity":"1d","range":"1d","validRanges":["1d","5d","1mo","3mo","6mo","1y","2y","5y","10y","ytd","max"]},"timestamp":[1583182801],"indicators":{"quote":[{"open":[282.2799987792969],"volume":[83324920],"close":[298.80999755859375],"high":[298.8500061035156],"low":[277.7200012207031]}],"adjclose":[{"adjclose":[298.80999755859375]}]}}],"error":null}}
