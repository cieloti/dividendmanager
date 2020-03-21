//
//  AssetView.swift
//  DividendManager
//
//  Created by cieloti on 2020/02/01.
//  Copyright © 2020 cieloti. All rights reserved.
//
import Combine
import SwiftUI
import SwiftSoup
import UserNotifications

struct AssetView: View {
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Georgia-Bold", size: 20)!]
    }

    @EnvironmentObject var stocks: Stocks
    @State private var newItem = ""
    @State private var number = ""
    @State private var buttonEnable = true
    @State private var isSideMenuOpen: Bool = false
    @State private var filter: String = "All"

    let yahooApi = YahooAPI()
    let defaults = UserDefaults.standard

    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView {
                Form {
                    Section(header: Text(Constants.AssetText.ticker)) {
                        HStack() {
                            TextField(Constants.AssetText.addNewItem, text: $newItem)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField(Constants.AssetText.number, text: $number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(Constants.AssetText.add) {
                                if !self.newItem.isEmpty {
                                    self.stocks.items.append(self.yahooApi.getData(ticker:self.newItem.uppercased(), number:self.number, filter: self.filter))
                                    self.newItem = ""
                                    self.number = ""
                                }
                            }
                            .padding(.horizontal, 10.0)
                        }
                    }
                    Section(header: Text(Constants.AssetText.list)) {
                        List {
                            ForEach(stocks.items.filter({$0.filter == self.filter || self.filter == "All"}), id:\.self) { stock in
                                NavigationLink(destination: AssetDetailView(stock: stock)) {
                                    StockView(stock: stock)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .onDelete(perform: removeItems)
                            .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
                        }
                    }
                }
                .navigationBarTitle(Text(Constants.AssetText.navigation), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    withAnimation {
                        self.isSideMenuOpen.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                },
                trailing: Button(action: {
                    self.buttonEnable = false
                    // Timer.scheduledTimer(withTimeInterval: 1000.0, repeats: true) { timer in
                    self.updateItems(stocks: self.stocks)
                    // }
                    self.buttonEnable = true
                }){
                    Text(Constants.AssetText.refresh)
                }.disabled(!buttonEnable))
            }
            SideMenu(isOpen: self.$isSideMenuOpen, filter: self.$filter)
        }
    }

    func removeItems(at offsets: IndexSet) {
        for i in offsets {
            let s = (stocks.items.filter({$0.filter == self.filter || self.filter == "All"}))[i]
            for r in 0...stocks.items.count-1 {
                if stocks.items[r] == s {
                    stocks.items.remove(at: r)
                    break
                }
            }
        }
    }

    func updateItems(stocks: Stocks) {
        var temp: Stock
        for i in stocks.items {
            temp = self.yahooApi.getData(ticker: i.ticker, number: String(i.number), filter: i.filter)
            i.price = temp.price
            i.dividend = temp.dividend
            i.period = temp.period
            i.volume = temp.volume
            i.per = temp.per
            i.exdividend = temp.exdividend
        }
    }
}

struct SideMenu: View {
    private let width = UIScreen.main.bounds.width - 200
    @Binding var isOpen: Bool
    @Binding var filter: String
    
    var body: some View {
        HStack {
            SideMenuList(filter: self.$filter, selectedList: "All")
                .frame(width: self.width)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.default)
            Spacer()
        }.onTapGesture {
            self.isOpen.toggle()
        }
    }
}

struct SideMenuList: View {
    var menuList = AssetSubMenuModel()
    @Binding var filter: String
    @State var selectedList: String
    
    var body: some View {
        List {
            Text("모든 리스트").onTapGesture {
                self.filter = "All"
                self.selectedList = "All"
            }
//            .listRowBackground(self.selectedList == "All" ? Color(UIColor.systemGroupedBackground) : Color(UIColor.systemBackground))
                .listRowBackground(self.selectedList == "All" ? Color(UIColor.systemOrange) : Color(UIColor.systemGray))
            ForEach(menuList.menuItems, id:\.self) { menu in
                Text(menu.list).onTapGesture {
                    self.filter = menu.list
                    self.selectedList = menu.list
                }
//                .listRowBackground(self.selectedList == menu.list ? Color(UIColor.systemGroupedBackground) : Color(UIColor.systemBackground))
                .listRowBackground(self.selectedList == menu.list ?  Color(UIColor.systemOrange) : Color(UIColor.systemGray))
            }

            Spacer()
                .listRowBackground(Color(UIColor.systemGray))
            Spacer()
            .listRowBackground(Color(UIColor.systemGray))
            Spacer()
            .listRowBackground(Color(UIColor.systemGray))
            Text("리스트 추가").onTapGesture {
                self.alert()
            }
            .listRowBackground(Color(UIColor.systemGray))
            Text("리스트 삭제").onTapGesture {
                self.removeAlert()
            }
            .listRowBackground(Color(UIColor.systemGray))
            Spacer()
            .listRowBackground(Color(UIColor.systemGray))
            Spacer()
            .listRowBackground(Color(UIColor.systemGray))
            Spacer()
            .listRowBackground(Color(UIColor.systemGray))
        }
    }

    private func alert() {
        let alert = UIAlertController(title: "관심 그룹 추가", message: "관심 그룹을 추가하세요", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Enter some text"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let first = String((alert.textFields![0] as UITextField).text ?? "관심그룹 \(self.menuList.menuItems.count)")
            if first != "" {
                self.menuList.menuItems.append(AssetSubMenuList(list: first))
            }
            
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        showAlert(alert: alert)
    }
    
    private func removeAlert() {
        let alert = UIAlertController(title: "관심 그룹 삭제", message: "관심 그룹을 삭제하세요", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Enter some text"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let first = String((alert.textFields![0] as UITextField).text ?? "")
            if first != "" {
                for i in 0...self.menuList.menuItems.count-1 {
                    if self.menuList.menuItems[i].list == first {
                        self.menuList.menuItems.remove(at: i)
                        break
                    }
                }
            }
            
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        showAlert(alert: alert)
    }
    
    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }
    
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
    }
    
    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }
    
    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
}

#if false
var stocks = Stocks()
struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView().environmentObject(stocks)
    }
}
#endif
