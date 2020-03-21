////
////  PieChartItem.swift
////  DividendManager
////
////  Created by cieloti on 2020/03/21.
////  Copyright © 2020 cieloti. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//class PieChartItem {
//    var name: String! = ""
//    var value: Double = 0.0
//    var color: Color! = .blue
//
//    init(name: String, value: Double, color: Color? = nil) {
//        self.name = name
//        self.value = value
//        if let color = color {
//            self.color = color
//        } else {
//            self.color = .random()
//        }
//    }
//}
//
//extension CGFloat {
//    static func random() -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UInt32.max)
//    }
//}
//
//extension UIColor {
//    static func random() -> UIColor {
//        return UIColor(red:   .random(),
//                       green: .random(),
//                       blue:  .random(),
//                       alpha: 1.0)
//    }
//}
//
//extension Color {
//    static func random() -> Color {
//        return Color(UIColor.random())
//    }
//}
//
//class SlideData: Identifiable, ObservableObject {
//    let id: UUID = UUID()
//    var data: PieChartItem!
//    var annotation: String! = ""
//    var startAngle: Angle! = .degrees(0)
//    var endAngle: Angle! = .degrees(0)
//    var percentage: String! = ""
//}
//
//class PieChartData: ObservableObject {
//    @Published private(set) var data: [SlideData] = []
//
//    init(data: [Double]) {
//        var currentAngle: Double = -90
//        var slides: [SlideData] = []
//        let total = data.reduce(0.0, +)
//
//        for index in 0..<data.count {
//            let slide = SlideData()
//            slide.data = PieChartItem(name: "Data name \(index + 1)", value: data[index])
//
//            let percentage = data[index] / total * 100
//            slide.percentage = String(format: "%.1f", percentage)
//
//            slide.startAngle = .degrees(currentAngle)
//            let angle = data[index] * 360 / total
//            currentAngle += angle
//            slide.endAngle = .degrees(currentAngle)
//
//            slides.append(slide)
//        }
//        self.data = slides
//    }
//
//    init(data: [SlideData]) {
//        self.data = data
//    }
//}
