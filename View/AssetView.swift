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
    @State private var number = ""
    @EnvironmentObject var stocks: Stocks

    let yahooApi = YahooAPI()
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Constants.AssetText.assetTicker)) {
                    HStack() {
                        TextField(Constants.AssetText.assetAddNewItem, text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField(Constants.AssetText.assetNumber, text: $number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(Constants.AssetText.assetAdd) {
                            if !self.newItem.isEmpty {
                                self.stocks.items.append(self.yahooApi.getData(ticker:self.newItem.uppercased(), number:self.number))
                                self.newItem = ""
                                self.number = ""
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                }
                Section(header: Text(Constants.AssetText.assetList)) {
                    HStack {
                        Text(Constants.AssetText.assetListTicker)
                            .frame(width: 100, alignment: .leading)
                            .lineLimit(1)
                        Text(Constants.AssetText.assetListPrice)
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                        Text(Constants.AssetText.assetListDividend)
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                        Text(Constants.AssetText.assetListNumber)
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                    }
                    List {
                        ForEach(stocks.items, id:\.self) { stock in
                            NavigationLink(destination: AssetDetailView(stock: stock)) {
                                StockView(stock: stock)
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationBarTitle(Text(Constants.AssetText.assetNavigation), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
//                Timer.scheduledTimer(withTimeInterval: 1000.0, repeats: true) { timer in
                    self.updateItems(stocks: self.stocks)
//                }
            }){
                Text("Refresh")
            })
        }
    }

    func removeItems(at offsets: IndexSet) {
        stocks.items.remove(atOffsets:offsets)
    }

    func updateItems(stocks: Stocks) {
        var temp: Stock
        for i in stocks.items {
            temp = self.yahooApi.getData(ticker: i.ticker, number: String(i.number))
            i.price = temp.price
            i.dividend = temp.dividend
            i.period = temp.period
            i.volume = temp.volume
            i.per = temp.per
            i.exdividend = temp.exdividend
        }
    }
}

#if false
var stocks = Stocks()
struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView().environmentObject(stocks)
    }
}
#endif
