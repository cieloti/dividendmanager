//
//  Stocks.swift
//  DividendManager
//
//  Created by Kang Minwoo on 2020/02/18.
//  Copyright © 2020 Kang Minwoo. All rights reserved.
//

import SwiftUI

class Stocks: ObservableObject {
    @Published var items: [Stock] = []
}
