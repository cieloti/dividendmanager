//
//  PieChartView.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/21.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct PieChartView: View {
    var filterData: [FilterData]
    
    var pieChart: PieChartData {
        get {
            var data = [Double]()
            var annotation = [String]()
            for d in filterData {
                data.append(d.sum)
                annotation.append(d.list)
            }
            return PieChartData(data: data, annotation: annotation)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PieChart(pieChartData: self.pieChart)
                    .frame(width: geometry.size.width * 0.8,
                           height: geometry.size.width * 0.8)
            }
        }.padding()
    }
}
