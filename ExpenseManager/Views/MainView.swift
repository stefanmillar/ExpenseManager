//
//  MainView.swift
//  Expenses
//
//  Created by Stefan Millar on 2022-01-14.
//

import SwiftUI

struct MainView: View {
    @State var transactions: [Transaction]
    
    init() {
        transactions = [Transaction]()
    }
    
    var body: some View {
        TabView {
            ExpensesView(transactions: self.$transactions)
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            
            AddTransactionView(transactions: self.$transactions)
                .tabItem {
                    Label("", systemImage: "plus.app")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
