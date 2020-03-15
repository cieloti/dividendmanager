//
//  ContentView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    @EnvironmentObject var stocks: Stocks
    @State private var selection = 0
    @State private var isUnlocked = false
    
    var body: some View {
//        VStack {
//            if self.isUnlocked {
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
//            } else {
//                Text("Locked")
//            }
//        }.onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.isUnlocked = false
                    }
                }
            }
        } else {
            // no biometrics
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
