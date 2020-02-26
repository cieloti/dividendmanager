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
    
    func printData(ticker:String) {
        var test = [Double]()
        test = yahooData.getDividendData(ticker: ticker)
        for t in test {
            print(t)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
            Text("test")
            Button("printData") {
                self.printData(ticker:"AAPL")
            }
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
