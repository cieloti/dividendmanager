//
//  CalculateView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/25.
//  Copyright © 2020 cieloti. All rights reserved.
//
import UIKit
import SwiftUI

struct CalculateView: View {
    init() {
        currencyDic = webService.getCurrencyLocale()
    }

    @EnvironmentObject var stocks: Stocks
    let webService = WebService()
    let commonApi = CommonApi()

    @State var pickerSelected = 0
    var currencyDic: [String : Double] = [:]
    let month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    // 총 배당금
    var divTotal:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.dividend * Double(stock.number) * (currencyDic[stock.currency] ?? 1.0)
            }
            return ret
        }
    }

    var calculate:[DividendData] {
        get {
            var ret = [DividendData]()
            var sum = Array(repeating: 0.0, count: 12)
            for stock in stocks.items {
                // 한국주식은 야후에서 배당금 히스토리가 안나와서 한번에 나오게함
                if stock.ticker.suffix(2) == "KS" {
                    if let i = month.firstIndex(of: String(stock.exdividend.prefix(3))) {
                        if i != -1 {
                            sum[i] += stock.dividend * Double(stock.number)
                        }
                    }
                    continue
                }

                for d in stock.monthlyDiv {
                    if d.month != -1 {
                        sum[d.month] += d.dividend * Double(stock.number) * (currencyDic[stock.currency] ?? 1.0)
                    }
                }
            }
            for i in 0...11 {
                ret.append(DividendData(month: i, dividend: sum[i], currency:"USD"))
            }
            return ret
        }
    }

    var filterData: [FilterData] {
        get {
            var ret = [FilterData]()
            var b = false
            for stock in stocks.items {
                b = false
                for i in ret {
                    if i.list == stock.filter {
                        print(stock.filter)
                        i.sum += stock.dividend * Double(stock.number) * (currencyDic[stock.currency] ?? 1.0)
                        b = true
                    }
                }
                if !b {
                    ret.append(FilterData(list: stock.filter, sum: stock.dividend * Double(stock.number) * (currencyDic[stock.currency] ?? 1.0)))
                }
            }
            return ret
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text(Constants.CalculateText.estimate)
                        .font(.system(size: 28))
                        .fontWeight(.heavy)
                    Picker(selection: $pickerSelected, label: Text("")) {
                        Text(Constants.CalculateText.first).tag(0)
                        Text(Constants.CalculateText.second).tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    if self.pickerSelected == 0 { // 월별 배당금 차트
                        BarChart(calculate: calculate)
                        Text(Constants.CalculateText.empty)
                        Estimate(calculate: calculate)
                        Text(Constants.CalculateText.empty)
                    } else {
                        PieChartView(filterData: filterData)
                        Text(Constants.CalculateText.empty)
                        ForEach(filterData, id:\.self) { d in
                            HStack {
                                Text(d.list)
                                Spacer()
                                Text(String(format: "%.2f 원", d.sum))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical,5)
                        }
                        Text(Constants.CalculateText.empty)
                    }
                    Text("원 달러 환율 : " + String(format: "%g", (currencyDic["USD"] ?? 1.0)))
                    Spacer()
                }
            }
            .navigationBarTitle(Text(Constants.CalculateText.assetTotal + commonApi.getFormatString(c:divTotal)), displayMode: .inline)
        }
    }
}

#if false
struct CalculateView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateView()
    }
}
#endif

class FilterData: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var list: String
    var sum: Double

    init(list: String, sum: Double) {
        self.list = list
        self.sum = sum
    }

    static func == (lhs: FilterData, rhs: FilterData) -> Bool {
        return lhs.list == rhs.list
    }

    public func hash(into hasher: inout Hasher) {
         hasher.combine(list + "filterdata")
    }
}
