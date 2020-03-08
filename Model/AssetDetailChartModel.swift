//
//  AssetDetailChartModel.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/08.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation

struct AssetDetailChartModel {
    var date: [Int]
    var price: [Double]
    
    init(date: [Int], price: [Double]) {
        self.date = date
        self.price = price
    }
 }
