//
//  Constants.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct TabBarImageName {
        static let tabBar0 = "home"
        static let tabBar1 = "money"
        static let tabBar2 = "calculator"
    }
    
    struct TabBarText {
        static let tabBar0 = "홈"
        static let tabBar1 = "자산"
        static let tabBar2 = "배당금"
    }

    struct HomeText {
        static let asset = "자산현황"
        static let money = " 원"
    }

    struct AssetText {
        static let ticker = "종목의 Ticker를 입력하세요"
        static let list = "종목 리스트"
        static let navigation = "자산 현황"
        static let addNewItem = "종목 입력"
        static let number = "주식 수량"
        static let add = "추가"
        static let listTicker = "종목명"
        static let listPrice = "가격"
        static let listDividend = "주당배당금"
        static let listNumber = "주식수"
        static let refresh = "Refresh"
    }
    
    struct AssetDetailText {
        static let ticker = "종목명"
        static let price = "현재가"
        static let dividend = "배당금"
        static let dividendRatio = "배당률"
        static let marketCap = "시가총액"
        static let per = "PER"
        static let date = "배당일"
        static let number = "주식수"
        static let currency = "통화"
    }
    
    struct CalculateText {
        static let assetTotal = "총 배당금 : "
        static let estimate = "배당금 예상"
        static let perMonth = "월별"
        static let perQuater = "분기별"
        static let empty = ""
        static let currency = "환율"
    }
    
    struct YahooApiText {
        static let url = "https://query1.finance.yahoo.com/v8/finance/chart"
    }
}
