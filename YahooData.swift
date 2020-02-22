//
//  YahooData.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/22.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftSoup

class YahooData {
    func getData(ticker:String) -> Stock {
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
                            //print(try! element.text())
                            presentValue = Double(try! element.text()) ?? 0
    //                        print(presentValue)
                        }
                        break
                    case "td":
                        let e2:Elements = try! element.getElementsByAttributeValue("data-test", "DIVIDEND_AND_YIELD-value")
                        if e2.size() != 0 {
                            //print(try! element.text())
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
}
