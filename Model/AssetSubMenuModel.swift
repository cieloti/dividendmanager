//
//  AssetSubMenuModel.swift
//  DividendManager
//
//  Created by cieloti on 2020/03/14.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

class AssetSubMenuModel: ObservableObject {
    @Published var menuItems = [AssetSubMenuList]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(menuItems) {
                UserDefaults.standard.set(encoded, forKey: "submenu")
            }
        }
    }
    
    init() {
        if let menuItems = UserDefaults.standard.data(forKey: "submenu") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([AssetSubMenuList].self, from: menuItems) {
                self.menuItems = decoded
                return
            }
        }
        menuItems = []
    }
}

class AssetSubMenuList: Identifiable, Hashable, Codable {
    var id: String = UUID().uuidString
    var list: String
    
    init(list: String) {
        self.list = list
    }
    
    static func == (lhs: AssetSubMenuList, rhs: AssetSubMenuList) -> Bool {
        lhs.list == rhs.list
    }
    
    public func hash(into hasher: inout Hasher) {
         hasher.combine(list + "submenu")
    }
}
