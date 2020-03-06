//
//  CommonApi.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/07.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation

class CommonApi {
    func getFormatString(c: Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0;
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: NSNumber(value: c))!
    }
}
