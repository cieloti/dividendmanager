//
//  Stock.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct Stock: Identifiable, Hashable {
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
    
    /*
    enum CodingKeys: String, CodingKey {
        case id
        case ticker
        case price
        case dividend
        case period
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        ticker = try values.decode(String.self, forKey: .ticker)
        price = try values.decode(Double.self, forKey: .price)
        dividend = try values.decode(String.self, forKey: .dividend)
        period = try values.decode(String.self, forKey: .period)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(ticker, forKey: .ticker)
        try container.encode(price, forKey: .price)
        try container.encode(dividend, forKey: .dividend)
        try container.encode(period, forKey: .period)
    }
 */
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
    }
}

class Stocks: ObservableObject {
    @Published var items = [Stock]()
}
