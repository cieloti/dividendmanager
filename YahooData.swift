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
        var dividend = 0.0
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
                            presentValue = Double(String(try! element.text()).replacingOccurrences(of: ",", with: "")) ?? 0
                        }
                        break
                    case "td":
                        let e2:Elements = try! element.getElementsByAttributeValue("data-test", "DIVIDEND_AND_YIELD-value")
                        if e2.size() != 0 {
                            dividend = Double(String((try! element.text()).split(separator: " ")[0]).replacingOccurrences(of: ",", with: "")) ?? 0
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

        return Stock(ticker: ticker, price: presentValue, dividend: dividend, period: dividendRatio, number:num, volume:volume, per:per, exdividend: exdividend)
    }
    
    var start = Date().addingTimeInterval(-31536000)
    var end = Date()
    
    func getDividendData(ticker:String) -> [Double] {
        var dividend = [Double]()
        var temp = 0.0
        
        print(start)
        print(end)
        
        if let url = URL(string:"https://finance.yahoo.com/quote/\(ticker)/history?period1=1551180701&period2=1582716701&interval=div%7Csplit&filter=div&frequency=1mo") {
            do {
                let contents = try String(contentsOf: url)
                let doc: Document = try SwiftSoup.parse(contents)
                let elements = try doc.getAllElements()
                for element in elements {
                    switch element.tagName() {
                    case "td":
                        let e1:Elements = try! element.getElementsByClass("Py(10px) Ta(start) Pend(10px)")
                        if e1.size() != 0 {
                            print(String((try! e1.text()).split(separator: " ")[0]))
                        }
                        let e2:Elements = try! element.getElementsByClass("Ta(c) Py(10px) Pstart(10px)")
                        if e2.size() != 0 {
                            temp = Double(String((try! e2.text()).split(separator: " ")[0]).replacingOccurrences(of: ",", with: "")) ?? 0
                            print("temp : \(temp)")
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

        return dividend
    }
}
