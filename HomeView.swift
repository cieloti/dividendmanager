//
//  HomeView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var asset = "자산현황"
    var money = "원"
    
    var body: some View {
        VStack() {
            Text(asset)
                .font(.largeTitle)
            Text(money)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeAssetView: View {
    var textString: String
    var font: Font
    
    var body: some View {
        Text(textString)
            .font(font)
    }
}
