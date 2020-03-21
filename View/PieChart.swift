//
//  PieChart.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/21.
//  Copyright © 2020 cieloti. All rights reserved.
//

//import SwiftUI
//import Combine
//
//public struct PieChartSlide: View {
//    var geometry: GeometryProxy
//    var slideData: SlideData
//    
//    var path: Path {
//        let chartSize = geometry.size.width
//        let radius = chartSize / 2
//        let centerX = radius
//        let centerY = radius
//        
//        var path = Path()
//        path.move(to: CGPoint(x: centerX, y: centerY))
//        path.addArc(center: CGPoint(x: centerX, y: centerY),
//                    radius: radius,
//                    startAngle: slideData.startAngle,
//                    endAngle: slideData.endAngle,
//                    clockwise: false)
//        return path
//    }
//    
//    public var body: some View {
//        path.fill(slideData.data.color)
//            .overlay(path.stroke(Color.white, lineWidth: 1))
//    }
//}
//
//struct PieChart: View {
//    var pieChartData: PieChartData
//    
//    var body: some View {
//        GeometryReader { geometry in
//            self.makePieChart(geometry, pieChartData: self.pieChartData.data)
//        }
//    }
//    
//    func makePieChart(_ geometry: GeometryProxy, pieChartData: [SlideData]) -> some View {
//        return ZStack {
//            ForEach(0..<pieChartData.count, id: \.self) { index in
//                PieChartSlide(geometry: geometry, slideData: pieChartData[index])
//            }
//        }
//    }
//}
