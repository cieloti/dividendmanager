//
//  Stock.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

class Stock: Identifiable {
    var id: String = UUID().uuidString
    var ticker: String
    var price: Double
    var dividend: String
    var period: String
    
    init(ticker: String, price: Double, dividend: String, period: String) {
        self.ticker = ticker
        self.price = price
        self.dividend = dividend
        self.period = period
    }
}

let testData = [
    Stock(ticker: "GOOG", price: 1456, dividend: "3%", period: "Quarter"),
    Stock(ticker: "AMZN", price: 2000, dividend: "3%", period: "Quarter"),
    Stock(ticker: "AAPL", price: 315, dividend: "3%", period: "Quarter")
]

struct StockView: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            Text(stock.ticker)
                .frame(width: 80, alignment: .leading)
                .lineLimit(1)
            Text(String(format: "%.2f", stock.price))
                .frame(width: 80, alignment: .leading)
                .lineLimit(1)
            Text("\(stock.dividend)")
                .frame(width: 80, alignment: .leading)
                .lineLimit(1)
            Text("\(stock.period)")
                .frame(width: 80, alignment: .leading)
                .lineLimit(1)
        }
        .padding(.all)
    }
}
