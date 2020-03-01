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

    let yahooData = YahooData()
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
                                self.stocks.items.append(self.yahooData.getData(ticker:self.newItem.uppercased(), number:self.number))
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
                            .frame(width: 80, alignment: .leading)
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
//            .navigationBarItems(trailing: Button(action: {
//                let s = Stock(ticker: "1", price: 0.0, dividend: "", period: "")
//                self.stocks.items.append(s)
//            }){
//                Image(systemName: "plus")
//            })
        }
    }

    func removeItems(at offsets: IndexSet) {
        stocks.items.remove(atOffsets:offsets)
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
