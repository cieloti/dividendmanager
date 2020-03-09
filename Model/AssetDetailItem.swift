//
//  AssetDetailItem.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/07.
//  Copyright © 2020 cieloti. All rights reserved.
//
import Foundation

struct AssetDetailItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var first: String
    var second: String

    init(first: String, second: String) {
        self.first = first
        self.second = second
    }
}
