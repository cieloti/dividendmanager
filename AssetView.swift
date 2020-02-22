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
//        self.stocks = defaults.object(forKey: "test") as? [Stock] ?? [Stock]()
    }
    
    @State private var newItem = ""
    @State private var showEditTextField = false
    @State private var editedItem = ""
    @ObservedObject var stocks = Stocks()
//    @EnvironmentObject var stocks: Stocks
//    @State private var stocks: [Stock] = []

    let yahooData = YahooData()
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Constants.AssetText.assetTicker)) {
                    HStack() {
                        TextField(Constants.AssetText.assetAddNewItem, text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(Constants.AssetText.assetAdd) {
                            if !self.newItem.isEmpty {
                                self.stocks.items.append(self.yahooData.getData(ticker:self.newItem.uppercased()))
                                self.newItem = ""
                                // print("size \(self.stocks.count)")
//                                self.defaults.set(self.stocks, forKey: "test")
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
