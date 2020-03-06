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
                Text(Constants.AssetDetailText.ticker)
                Spacer()
                Text(stock.longName)
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.price)
                Spacer()
                Text(String(format: "%.2f", stock.price))
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.dividend)
                Spacer()
                Text(String(format: "%.2f", stock.dividend))
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.dividendRatio)
                Spacer()
                Text(stock.period)
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.marketCap)
                Spacer()
                Text(stock.volume)
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.per)
                Spacer()
                Text(String(format: "%.2f", stock.per))
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.date)
                Spacer()
                Text(stock.exdividend)
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.currency)
                Spacer()
                Text("\(stock.currency)")
            }
            .padding(.all, 5)
            HStack {
                Text(Constants.AssetDetailText.number)
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
