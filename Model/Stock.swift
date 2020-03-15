//
//  Stock.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftUI

class Stock: Identifiable, Hashable, Codable {
    var id: String = UUID().uuidString
    var ticker: String
    var price: Double
    var dividend: Double
    var period: String
    var number: Int
    var volume: String
    var per: Double
    var exdividend: String
    var currency: String
    var longName: String
    var filter: String
    var monthlyDiv: [DividendData]

    init(ticker: String, price: Double, dividend: Double, period: String, number:Int, volume:String, per:Double, exdividend:String, currency: String, longName: String, filter: String, monthlyDiv: [DividendData]) {
        self.ticker = ticker
        self.price = price
        self.dividend = dividend
        self.period = period
        if number <= 0 {
            self.number = 0
        } else {
            self.number = number
        }
        self.volume = volume
        self.per = per
        self.exdividend = exdividend
        self.currency = currency
        self.longName = longName
        self.filter = filter
        self.monthlyDiv = monthlyDiv
    }

    static func == (lhs: Stock, rhs: Stock) -> Bool {
        return lhs.ticker == rhs.ticker && lhs.filter == rhs.filter
    }

    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self).hashValue)
    }
}
