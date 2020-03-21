//
//  BarChartView.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/21.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

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
