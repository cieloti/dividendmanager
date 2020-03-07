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

    var details: [AssetDetailItem] {
        get {
            var ret = [AssetDetailItem]()
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.ticker, second: stock.longName))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.price, second: String(format: "%.2f", stock.price)))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.dividend, second: String(format: "%.2f", stock.dividend)))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.dividendRatio, second: stock.period))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.marketCap, second: stock.volume))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.per, second:String(format: "%.2f", stock.per)))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.date, second: stock.exdividend))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.currency, second: stock.currency))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.number, second: "\(stock.number)"))
            ret.append(AssetDetailItem(first: "", second: ""))
            return ret
        }
    }

    var body: some View {
        VStack {
            Group {
                Spacer()
            }
            Group {
                ForEach(details, id: \.self) { detail in
                    VStack {
                        HStack {
                            Text(detail.first)
                            Spacer()
                            Text(detail.second)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
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
