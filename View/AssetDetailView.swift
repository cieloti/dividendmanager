//
//  AssetDetailView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/22.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftUI
//import Charts

struct AssetDetailView: View {
    var stock: Stock

    var details: [AssetDetailItem] {
        get {
            var ret = [AssetDetailItem]()
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.ticker, second: stock.longName))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.price, second: String(format: "%.2f", stock.price)))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.dividend, second: String(format: "%.2f", stock.dividend)))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.dividendRatio, second: stock.period))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.marketCap, second: stock.volume))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.per, second:String(format: "%.2f", stock.per)))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.date, second: stock.exdividend))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.currency, second: stock.currency))
            ret.append(AssetDetailItem(first: Constants.AssetDetailText.number, second: "\(stock.number)"))
            ret.append(AssetDetailItem(first: "", second: ""))
            return ret
        }
    }

    var body: some View {
        VStack {
            Group {
                Spacer()
//                GeometryReader { p in
//                    VStack {
//                        LineChartSwiftUI(stock: self.stock)
//                            .frame(width: p.size.width, height: p.size.height, alignment: .center)
//                    }
//                }
            }
            Group {
                ForEach(details, id: \.self) { detail in
                    VStack {
                        HStack {
                            Text(detail.first)
                            Spacer()
                            Text(detail.second)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }
}

#if false
var stock = Stock(ticker: "", price: 0.0, dividend: "", period: "", number: 0)
struct AssetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailView(stock: stock)
    }
}
#endif
/*
struct LineChartSwiftUI: UIViewRepresentable {
    let lineChart = LineChartView()
    let yahooApi = YahooAPI()
    var stock: Stock

    func makeUIView(context: UIViewRepresentableContext<LineChartSwiftUI>) -> LineChartView {
        setUpChart()
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChartSwiftUI>) {

    }

    func setUpChart() {
        lineChart.noDataText = "No Data Available"
        let dataSets = [getLineChartDataSet()]
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        lineChart.data = data
    }

    func getChartDataPoints(sessions: [Int], accuracy: [Double]) -> [ChartDataEntry] {
        var dataPoints: [ChartDataEntry] = []
        for count in (0..<sessions.count) {
            dataPoints.append(ChartDataEntry.init(x: Double(sessions[count]), y: accuracy[count]))
        }
        return dataPoints
    }

    func getLineChartDataSet() -> LineChartDataSet {
        let response = yahooApi.getChart(ticker: stock.ticker)
        
        let dataPoints = getChartDataPoints(sessions: response.date, accuracy: response.price)
        let set = LineChartDataSet(entries: dataPoints, label: "1mo")
        set.lineWidth = 2.5
        set.circleRadius = 4
        set.circleHoleRadius = 2
        let color = ChartColorTemplates.vordiplom()[0]
        set.setColor(color)
        set.setCircleColor(color)
        return set
    }
}
*/
