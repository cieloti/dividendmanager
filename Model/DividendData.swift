//
//  DividendData.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/27.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftUI

struct DividendData: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var month:Int
    var dividend:Double
    
    init(month:Int, dividend:Double) {
        self.month = month
        self.dividend = dividend
    }
}
