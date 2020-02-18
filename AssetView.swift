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
    init(stocks:Stocks) {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Georgia-Bold", size: 20)!]
        initData(ticker: "KO")
        self.stocks = stocks.items
    }
    
    @State private var newItem = Stock(ticker:"")
    @State private var showEditTextField = false
    @State private var editedItem = Stock(ticker:"")
    @State private var stocks: [Stock] = []
//    var stocks = testData
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top, spacing: 15) {
                    TextField("Add New Item", text: $newItem.ticker)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        if !self.newItem.ticker.isEmpty {
                            self.stocks.append(Stock(ticker: self.newItem.ticker))
                            self.newItem = Stock(ticker:"")
                            print("size \(self.stocks.count)")
                        }
                    }
                }
                List(stocks) { stock in
                    StockView(stock: stock)
                }
            }
            .navigationBarTitle(Text("종목명           가격          배당률    배당주기 "), displayMode: .inline)
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete button click")
    }
}

//struct AssetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetView(stocks:testD)
//    }
//}

func initData(ticker:String) {
    var presentValue:Double
    var dividend:String
    var dividendRatio:String
    
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
                        print(presentValue)
                    }
                    break
                case "td":
                    let e2:Elements = try! element.getElementsByAttributeValue("data-test", "DIVIDEND_AND_YIELD-value")
                    if e2.size() != 0 {
                        print(try! element.text())
                        dividend = String((try! element.text()).split(separator: " ")[0])
                        dividendRatio = String(String((try! element.text()).split(separator: " ")[1]).dropFirst().dropLast())
                        print("div = \(dividend)")
                        print("divratio = \(dividendRatio)")
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
}
