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
        currency = webService.getCurrency(from:"USD", to:"KRW")
    }

    @EnvironmentObject var stocks: Stocks
    let yahooData = YahooData()
    let webService = WebService()
    
    @State var pickerSelected = 0
    var currency: Double

    var divTotal:Double {
        get {
            var ret = 0.0
            for stock in stocks.items {
                ret += stock.dividend * Double(stock.number)
            }
            return ret
        }
    }

    var calculate:[DividendData] {
        get {
            var ret = [DividendData]()
            var sum = Array(repeating: 0.0, count: 12)
            for stock in stocks.items {
                for d in yahooData.getDividendData(ticker: stock.ticker) {
                    if d.month != -1 {
                        sum[d.month] += d.dividend * Double(stock.number)
                    }
                }
            }
            for i in 0...11 {
                ret.append(DividendData(month: i, dividend: sum[i]))
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
                        Text(Constants.CalculateText.perMonth).tag(0)
                        Text(Constants.CalculateText.perQuater).tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    
                    BarChart(calculate: calculate)
                    Text(Constants.CalculateText.empty)
                    Estimate(calculate: calculate)
                    Text(Constants.CalculateText.empty)
//                    Text("원 달러 환율 : " + String(format: "%g", currency))
//                    Text"원 달러 환율 : ").onAppear() {
                }
            }
            .navigationBarTitle(Text(Constants.CalculateText.assetTotal + String(format: "%.2f", divTotal)), displayMode: .inline)
        }
    }
}


struct BarChart: View {
    var calculate:[DividendData]

    var max: Double {
        get {
            return calculate.max {$0.dividend < $1.dividend}?.dividend ?? 0.0
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
