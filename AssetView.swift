//
//  AssetView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Combine
import SwiftUI
import SwiftSoup

struct AssetView: View {
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    @State private var newItem = ""
    @State private var showEditTextField = false
    @State private var editedItem = ""
//    @EnvironmentObject var stocks: Stocks
    @State private var stocks: [Stock] = []
    let yahooData = YahooData()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Constants.AssetText.assetTicker)) {
                    HStack() {
                        TextField(Constants.AssetText.assetAddNewItem, text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(Constants.AssetText.assetAdd) {
                            if !self.newItem.isEmpty {
                                self.stocks.append(self.yahooData.getData(ticker:self.newItem.uppercased()))
                                self.newItem = ""
                                // print("size \(self.stocks.count)")
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                }
                Section(header: Text(Constants.AssetText.assetList)) {
                    HStack {
                        Text("종목명")
                            .frame(width: 80, alignment: .leading)
                            .lineLimit(1)
                        Text("가격")
                            .frame(width: 80, alignment: .leading)
                            .lineLimit(1)
                        Text("배당금")
                            .frame(width: 80, alignment: .leading)
                            .lineLimit(1)
                        Text("배당률")
                            .frame(width: 80, alignment: .leading)
                            .lineLimit(1)
                    }
                    .padding(.all)
                    List(stocks) { stock in
                        NavigationLink(destination: AssetDetailView(stock: stock)) {
                            StockView(stock: stock)
                        }
                    }
                }
            }
            .navigationBarTitle(Text(Constants.AssetText.assetNavigation), displayMode: .inline)
        }
    }
}

#if true
var stocks = Stocks()
struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView().environmentObject(stocks)
    }
}
#endif
