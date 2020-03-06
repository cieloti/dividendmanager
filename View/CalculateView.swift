//
//  CalculateView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/25.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct CalculateView: View {
    init() {
        currencyUSD = webService.getCurrency(from:"USD", to:"KRW")
        currencyCNY = webService.getCurrency(from:"CNY", to:"KRW")
    }

    @EnvironmentObject var stocks: Stocks
    let webService = WebService()
    let yahooApi = YahooAPI()
    let commonApi = CommonApi()
    
    @State var pickerSelected = 0
    var currencyUSD: Double
    var currencyKRW = 1.0
    var currencyCNY: Double
    let month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    // 총 배당금
    var divTotal:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.dividend * Double(stock.number) * getCurrency(currency: stock.currency)
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
                // 야후 rest api를 사용하여 배당내역 받아옴
                for d in yahooApi.getDividendData(ticker: stock.ticker) {
                    if d.month != -1 {
                        sum[d.month] += d.dividend * Double(stock.number) * getCurrency(currency: stock.currency)
                    }
                }
            }
            for i in 0...11 {
                ret.append(DividendData(month: i, dividend: sum[i], currency:"USD"))
            }
            return ret
        }
    }
    
    func getCurrency(currency: String) -> Double {
        switch(currency) {
        case "USD":
            return currencyUSD
        case "CNY":
            return currencyCNY
        default:
            return currencyKRW
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
                        Text(Constants.CalculateText.perMonth).tag(0)
                        Text(Constants.CalculateText.perQuater).tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    
                    BarChart(calculate: calculate)
                    Text(Constants.CalculateText.empty)
                    Estimate(calculate: calculate)
                    Text(Constants.CalculateText.empty)
                    Text("원 달러 환율 : " + String(format: "%g", currencyUSD))
                }
            }
            .navigationBarTitle(Text(Constants.CalculateText.assetTotal + commonApi.getFormatString(c:divTotal)), displayMode: .inline)
        }
    }
}

// 월별 배당금 차트
struct BarChart: View {
    var calculate:[DividendData]

    var max: Double {
        get {
            let ret = calculate.max {$0.dividend < $1.dividend}?.dividend ?? 0.0
            return ret != 0.0 ? ret : 1.0

        }
    }
    
    var body: some View {
        HStack {
            ForEach(calculate, id:\.self) { c in
                VStack {
                    ZStack(alignment:.bottom) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 20, height: 200)
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 20, height: CGFloat(c.dividend / (self.max / 200.0)))
                    }
                    Text("\(Calendar.current.shortMonthSymbols[c.month])")
                        .font(.footnote)
                        .frame(height: 20)
                }
            }
        }
    }
}

// 월별 배당금 예상금액
struct Estimate: View {
    var calculate:[DividendData]

    var body: some View {
        ForEach(calculate, id:\.self) { c in
            HStack {
                Text("\(Calendar.current.shortMonthSymbols[c.month])")
                    .padding(.horizontal)
                    .frame(width: 80, alignment: .leading)
                Text("\(c.dividend, specifier:"%g")")
                    .frame(width: 80, alignment: .leading)
                Text("원")
                Spacer()
            }
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
