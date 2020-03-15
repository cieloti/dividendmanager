//
//  DividendData.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/27.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftUI

struct DividendData: Identifiable, Hashable, Codable, Comparable {
    var id: String = UUID().uuidString
    var month:Int
    var dividend:Double
    var currency:String
    
    init(month:Int, dividend:Double, currency:String) {
        self.month = month
        self.dividend = dividend
        self.currency = currency
    }
    
    static func < (lhs: DividendData, rhs: DividendData) -> Bool {
        return lhs.month < rhs.month
    }
}
