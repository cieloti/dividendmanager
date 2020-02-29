//
//  CalculateView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/25.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct CalculateView: View {
    @EnvironmentObject var stocks: Stocks
    let yahooData = YahooData()

    var count:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.price * Double(stock.number)
            }
            return ret
        }
    }

    var divTotal:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.dividend * Double(stock.number)
            }
            return ret
        }
    }
    
    var calculate:[DividendData] {
        get {
            var ret = [DividendData]()
            var sum = Array(repeating: 0.0, count: 12)
            for stock in stocks.items {
                for d in yahooData.getDividendData(ticker: stock.ticker) {
                    if d.month != -1 {
                        sum[d.month] += d.dividend
                    }
                }
            }
            for i in 0...11 {
                ret.append(DividendData(month: i, dividend: sum[i]))
            }
            return ret
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("월별 배당금 예상")
                HStack {
                    ForEach(calculate, id:\.self) { c in
                    VStack {
                      Spacer()
                      Rectangle()
                        .fill(Color.green)
                        .frame(width: 20, height: CGFloat(c.dividend) * 100)
                        Text("\(Calendar.current.shortMonthSymbols[c.month])")
                        .font(.footnote)
                        .frame(height: 20)
                    }
                  }
                }
                Text("test")
            }
            .navigationBarTitle(Text(Constants.CalculateText.assetTotal + "\(divTotal)"), displayMode: .inline)
        }
    }
}

#if false
struct CalculateView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateView()
    }
}
#endif
