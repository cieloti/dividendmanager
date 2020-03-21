//
//  PieChartModel.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/21.
//  Copyright © 2020 cieloti. All rights reserved.
//
//
//
//import Combine
//import Foundation
//
//class PieChartModel: ObservableObject {
//    @Published var pieChartData = PieChartData(data: [Double]())
//    
//    func randomData() {
//        let number = Int.random(in: 3...7)
//        var values: [Double] = []
//        for _ in 0..<number {
//            values.append(Double.random(in: 10...50))
//        }
//        print("\(values)")
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.pieChartData = PieChartData(data: values)
//        }
//    }
//}
