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

    @EnvironmentObject var stocks: Stocks
    @State private var newItem = ""
    @State private var number = ""
    @State private var buttonEnable = true

    let yahooApi = YahooAPI()
    let defaults = UserDefaults.standard

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Constants.AssetText.ticker)) {
                    HStack() {
                        TextField(Constants.AssetText.addNewItem, text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField(Constants.AssetText.number, text: $number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(Constants.AssetText.add) {
                            if !self.newItem.isEmpty {
                                self.stocks.items.append(self.yahooApi.getData(ticker:self.newItem.uppercased(), number:self.number))
                                self.newItem = ""
                                self.number = ""
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                }
                Section(header: Text(Constants.AssetText.list)) {
                    HStack {
                        Text(Constants.AssetText.listTicker)
                            .frame(width: 100, alignment: .leading)
                            .lineLimit(1)
                        Text(Constants.AssetText.listPrice)
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                        Text(Constants.AssetText.listDividend)
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                        Text(Constants.AssetText.listNumber)
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
            .navigationBarTitle(Text(Constants.AssetText.navigation), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.buttonEnable = false
//                Timer.scheduledTimer(withTimeInterval: 1000.0, repeats: true) { timer in
                    self.updateItems(stocks: self.stocks)
//                }
                self.buttonEnable = true
            }){
                Text(Constants.AssetText.refresh)
                }.disabled(!buttonEnable))
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
