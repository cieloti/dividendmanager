//
//  HomeView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var stocks: Stocks
    let webService = WebService()
    let commonApi = CommonApi()
    var currencyDic: [String : Double] = [:]
    
    init() {
        currencyDic = webService.getCurrencyLocale()
    }
    
    var count:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.price * Double(stock.number) * (currencyDic[stock.currency] ?? 1.0)
            }
            return ret
        }
    }

    var body: some View {
        VStack() {
            Text(Constants.HomeText.asset)
                .font(.largeTitle)
            Text(commonApi.getFormatString(c:count))
                .font(.title)
        }
    }
}

#if false
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif

struct HomeAssetView: View {
    var textString: String
    var font: Font
    
    var body: some View {
        Text(textString)
            .font(font)
    }
}
