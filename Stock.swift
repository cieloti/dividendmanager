//
//  Stock.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct Stock: Identifiable, Hashable, Codable {
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
    
    init(ticker: String, price: Double, dividend: Double, period: String, number:Int, volume:String, per:Double, exdividend:String, currency: String) {
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
    }
}

struct StockView: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            Text(stock.ticker)
                .frame(width: 80, alignment: .leading)
                .lineLimit(1)
            Text(String(format: "%.2f", stock.price))
                .frame(width: 80, alignment: .center)
                .lineLimit(1)
            Text(String(format: "%.2f", stock.dividend))
                .frame(width: 80, alignment: .center)
                .lineLimit(1)
            Text("\(stock.number)")
                .frame(width: 80, alignment: .center)
                .lineLimit(1)
        }
    }
}
