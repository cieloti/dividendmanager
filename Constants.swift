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
        static let money = "원"
    }

    struct AssetText {
        static let assetTicker = "종목의 Ticker를 입력하세요"
        static let assetList = "종목 리스트"
        static let assetNavigation = "자산 현황"
        static let assetAddNewItem = "종목 입력"
        static let assetNumber = "주식 수량"
        static let assetAdd = "추가"
        static let assetListTicker = "종목명"
        static let assetListPrice = "가격"
        static let assetListDividend = "주당배당금"
        static let assetListNumber = "주식수"
    }
    
    struct CalculateText {
        static let assetTotal = "총 배당금 : "
    }
}
