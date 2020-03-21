//
//  StockView.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/11.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation
import SwiftUI

struct StockView: View {
    let stock: Stock
    
    var divMonth: String {
        get {
            var ret = ""
            for i in stock.monthlyDiv {
                ret += "\(i.month+1) "
            }
            return ret
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(" " + stock.ticker)
                    .frame(width: 101, alignment: .leading)
                    .lineLimit(1)
                VStack {
                    HStack {
                        Text("가격")
                            .frame(width: 40, alignment: .leading)
                        Text(String(format: "%.2f", stock.price))
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                        Text("주당배당금")
                            .frame(width: 70, alignment: .leading)
                        Text(String(format: "%.2f", stock.dividend))
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                    }
                    .padding(.vertical, 5)
                    HStack {
                        Text("주식수")
                            .frame(width: 40, alignment: .leading)
                        Text("\(stock.number)")
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                        Text("통화")
                            .frame(width: 70, alignment: .leading)
                        Text(stock.currency)
                            .frame(width: 80, alignment: .center)
                            .lineLimit(1)
                    }
                    .padding(.bottom, 5)
                }
                .font(.system(size: 15))
            }
            .background(Color.orange)
            .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
            HStack {
                Text("배당월")
                    .frame(width: 100, alignment: .center)
                    .lineLimit(1)
                .font(.caption)
                Text(divMonth)
                    .frame(width: 295, alignment: .leading)
                    .lineLimit(1)
                .font(.caption)
            }
            .padding(.vertical, 5)
            .background(Color.gray)
            .cornerRadius(radius: 25, corners: [.bottomLeft, .bottomRight])
        }
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


