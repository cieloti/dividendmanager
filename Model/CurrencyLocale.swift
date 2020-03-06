//
//  CurrencyLocale.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/06.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation

class CurrencyLocale: ObservableObject {
    var USD: Double
    var KRW: Double
    var HKD: Double
    var CNY: Double
    
    init(USD: Double, KRW: Double, HKD: Double, CNY: Double) {
        self.USD = USD
        self.KRW = KRW
        self.HKD = HKD
        self.CNY = CNY
    }
}
