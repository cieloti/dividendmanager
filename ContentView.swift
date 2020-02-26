//
//  ContentView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    @EnvironmentObject var stocks: Stocks
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            HomeView().tabItem({
                Image(Constants.TabBarImageName.tabBar0)
                Text("\(Constants.TabBarText.tabBar0)")
                }).tag(0).environmentObject(stocks)
            
            AssetView().tabItem({
                Image(Constants.TabBarImageName.tabBar1)
                Text("\(Constants.TabBarText.tabBar1)")
                }).tag(1).environmentObject(stocks)

            CalculateView().tabItem({
                Image(Constants.TabBarImageName.tabBar2)
                Text("\(Constants.TabBarText.tabBar2)")
                }).tag(2).environmentObject(stocks)
        }
    }
}

#if false
var items = Stocks()
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(items)
    }
}
#endif
