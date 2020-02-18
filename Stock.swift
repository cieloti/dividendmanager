//
//  Stock.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct Stock: Identifiable {
    var id: String = UUID().uuidString
    var ticker: String
    var price: Double
    var dividend: String
    var period: String
    
    init(ticker: String) {
        self.ticker = ticker
        self.price = 0.0
        self.dividend = "0%"
        self.period = "Quater"
    }
}

let testData = [
    Stock(ticker: "AAPL"),
    Stock(ticker: "GOOG")
//    Stock(ticker: "GOOG", price: 1456, dividend: "3%", period: "Quarter"),
//    Stock(ticker: "AMZN", price: 2000, dividend: "3%", period: "Quarter"),
//    Stock(ticker: "AAPL", price: 315, dividend: "3%", period: "Quarter"),
//    Stock(ticker: "GOOG", price: 1456, dividend: "3%", period: "Quarter"),
//    Stock(ticker: "AMZN", price: 2000, dividend: "3%", period: "Quarter"),
//    Stock(ticker: "AAPL",  price: 315, dividend: "3%", period: "Quarter"),
]

struct StockView: View {
    let stock: Stock
    
    var body: some View {
        HStack(spacing: 15) {
            Text(stock.ticker)
                .frame(width: 80, alignment: .center)
                .lineLimit(1)
            Text(String(format: "%.2f", stock.price))
                .frame(width: 100, alignment: .center)
                .lineLimit(1)
            Text("\(stock.dividend)")
                .frame(width: 60, alignment: .center)
                .lineLimit(1)
            Text("\(stock.period)")
                .frame(width: 60, alignment: .center)
                .lineLimit(1)
        }
        .padding([.leading, .bottom], 13)
        .padding(.trailing, 15)
        
    }
}

struct DetailView:View {
    var select: String
    var body: some View {
        Text(select)
    }
}
