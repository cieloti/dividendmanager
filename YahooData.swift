//
//  YahooData.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/22.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftSoup

class YahooData {
    func getData(ticker:String, number:String) -> Stock {
        var presentValue = 0.0
        var dividend = ""
        var dividendRatio = ""
        var volume = ""
        var per = 0.0
        var exdividend = ""
        let num = Int(number) ?? 0
        
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
                            presentValue = Double(try! element.text()) ?? 0
                        }
                        break
                    case "td":
                        let e2:Elements = try! element.getElementsByAttributeValue("data-test", "DIVIDEND_AND_YIELD-value")
                        if e2.size() != 0 {
                            dividend = String((try! element.text()).split(separator: " ")[0])
                            dividendRatio = String(String((try! element.text()).split(separator: " ")[1]).dropFirst().dropLast())
                        }
                        let e3:Elements = try! element.getElementsByAttributeValue("data-test", "MARKET_CAP-value")
                        if e3.size() != 0 {
                            let e4:Elements = try! element.getElementsByClass("Trsdu(0.3s)")
                            if e4.size() != 0 {
                                volume = String(try! element.text())
                            }
                        }
                        let e5:Elements = try! element.getElementsByAttributeValue("data-test", "PE_RATIO-value")
                        if e5.size() != 0 {
                            let e6:Elements = try! element.getElementsByClass("Trsdu(0.3s)")
                            if e6.size() != 0 {
                                per = Double(try! element.text()) ?? 0
                            }
                        }
                        let e7:Elements = try! element.getElementsByAttributeValue("data-test", "EX_DIVIDEND_DATE-value")
                        if e7.size() != 0 {
//                            let e6:Elements = try! element.getElementsByClass("Trsdu(0.3s)")
//                            if e6.size() != 0 {
//                                per = Double(try! element.text()) ?? 0
//                            }
                            exdividend = String(try! element.text())
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
        return Stock(ticker: ticker, price: presentValue, dividend: dividend, period: dividendRatio, number:num, volume:volume, per:per, exdividend: exdividend)
    }
}
