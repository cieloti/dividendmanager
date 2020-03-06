//
//  YahooAPIModel.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/05.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation

struct QuoteResponse: Codable {
    var quoteResponse: Result
}

struct Result: Codable {
    var result: [QuoteDetail]
}

struct QuoteDetail: Codable {
    var currency: String
    var trailingAnnualDividendRate: Double
    var trailingPE: Double
    var epsTrailingTwelveMonths: Double
    var regularMarketPrice: Double
    var priceToBook: Double
    var marketCap: Double
    var symbol: String
    var dividendDate: Int
    var longName: String
}

struct KNFQuoteResponse: Codable {
    var quoteResponse: KNFResult
}

struct KNFResult: Codable {
    var result: [KNFQuoteDetail]
}

struct KNFQuoteDetail: Codable {
    var currency: String
    var trailingPE: Double
    var epsTrailingTwelveMonths: Double
    var regularMarketPrice: Double
    var priceToBook: Double
    var marketCap: Double
    var symbol: String
    var longName: String
}
