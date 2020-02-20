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
//    var stocks = testData
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top, spacing: 15) {
                    TextField("Add New Item", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        if !self.newItem.isEmpty {
                            //                            self.stocks.items.append(Stock(ticker: self.newItem.ticker))
//                            self.stocks.append(Stock(ticker: self.newItem.ticker))
                            self.stocks.append(initData(ticker: self.newItem.uppercased()))
                            self.newItem = ""
                            print("size \(self.stocks.count)")
                        }
                    }
                }
                //                List(stocks.items
                List(stocks) { stock in
                    StockView(stock: stock)
                }
            }
            .navigationBarTitle(Text("종목명           가격        배당금      배당률 "), displayMode: .inline)
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete button click")
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

func initData(ticker:String) -> Stock {
    var presentValue = 0.0
    var dividend = ""
    var dividendRatio = ""
    
    if let url = URL(string:"https://finance.yahoo.com/quote/\(ticker)?p=\(ticker)") {
        do {
            let contents = try String(contentsOf: url)
            let doc: Document = try SwiftSoup.parse(contents)
            let elements = try doc.getAllElements()
            for element in elements {
                switch element.tagName() {
                case "span":
                    let e1:Elements = try! element.getElementsByClass("Trsdu(0.3s) Trsdu(0.3s) Fw(b) Fz(36px) Mb(-4px) D(b)")
                    if e1.size() != 0 {
                        print(try! element.text())
                        presentValue = Double(try! element.text()) ?? 0
//                        print(presentValue)
                    }
                    break
                case "td":
                    let e2:Elements = try! element.getElementsByAttributeValue("data-test", "DIVIDEND_AND_YIELD-value")
                    if e2.size() != 0 {
                        print(try! element.text())
                        dividend = String((try! element.text()).split(separator: " ")[0])
                        dividendRatio = String(String((try! element.text()).split(separator: " ")[1]).dropFirst().dropLast())
//                        print("div = \(dividend)")
//                        print("divratio = \(dividendRatio)")
                    }
                    break
                default:
                    let _ = 1
                }
            }
        } catch {
            print("url contents fail")
        }
    }
//    print("ticker \(ticker) dividend : \(dividend)")
    return Stock(ticker: ticker, price: presentValue, dividend: dividend, period: dividendRatio)
}
