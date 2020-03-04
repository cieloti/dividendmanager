//
//  AssetDetailView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/22.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct AssetDetailView: View {
    var stock: Stock

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text("종목명")
                Spacer()
                Text(stock.ticker)
            }
            .padding(.all, 5)
            HStack {
                Text("현재가")
                Spacer()
                Text(String(format: "%.2f", stock.price))
            }
            .padding(.all, 5)
            HStack {
                Text("배당금")
                Spacer()
                Text(String(format: "%.2f", stock.dividend))
            }
            .padding(.all, 5)
            HStack {
                Text("배당률")
                Spacer()
                Text(stock.period)
            }
            .padding(.all, 5)
            HStack {
                Text("시가총액")
                Spacer()
                Text(stock.volume)
            }
            .padding(.all, 5)
            HStack {
                Text("PER")
                Spacer()
                Text(String(format: "%.2f", stock.per))
            }
            .padding(.all, 5)
            HStack {
                Text("배당락일")
                Spacer()
                Text(stock.exdividend)
            }
            .padding(.all, 5)
            HStack {
                Text("주식수")
                Spacer()
                Text("\(stock.number)")
            }
            .padding(.all, 5)
        }
        .padding(.all)
    }
}

#if false
var stock = Stock(ticker: "", price: 0.0, dividend: "", period: "", number: 0)
struct AssetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailView(stock: stock)
    }
}
#endif
