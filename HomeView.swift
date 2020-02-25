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
    
    var count:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.price * Double(stock.number)
            }
            return ret
        }
    }

    var body: some View {
        VStack() {
            Text(Constants.HomeText.asset)
                .font(.largeTitle)
            Text("\(count) " + Constants.HomeText.money)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeAssetView: View {
    var textString: String
    var font: Font
    
    var body: some View {
        Text(textString)
            .font(font)
    }
}
