//
//  WebServiceModel.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/05.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation

struct Currency: Codable {
    var base: String
    var date: String
    var rates: Rates
}

struct Rates: Codable {
    var USD: Double
    var KRW: Double
    var HKD: Double
    var CNY: Double
    var JPY: Double
}

// JSON String format below {"rates":{"CAD":1.4757,"HKD":8.555,"ISK":139.3,"PHP":56.027,"DKK":7.4723,"HUF":337.57,"CZK":25.39,"AUD":1.6875,"RON":4.813,"SEK":10.6738,"IDR":15749.25,"INR":79.285,"BRL":4.9232,"RUB":73.6096,"HRK":7.4695,"JPY":119.36,"THB":34.632,"CHF":1.0614,"SGD":1.5317,"PLN":4.3259,"BGN":1.9558,"TRY":6.8348,"CNY":7.6662,"NOK":10.3888,"NZD":1.7608,"ZAR":17.0961,"USD":1.0977,"MXN":21.637,"ILS":3.8052,"GBP":0.85315,"KRW":1324.98,"MYR":4.6263},"base":"EUR","date":"2020-02-28"}
