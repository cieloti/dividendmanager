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
                Text(stock.dividend)
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
                Text(stock.period)
            }
            .padding(.all, 5)
            HStack {
                Text("PER")
                Spacer()
                Text(stock.period)
            }
            .padding(.all, 5)
        }
        .padding(.all)
    }
}

#if true
var stock = Stock(ticker: "", price: 0.0, dividend: "", period: "")
struct AssetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailView(stock: stock)
    }
}
#endif
