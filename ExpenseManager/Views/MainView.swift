//
//  MainView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-14.
//

import SwiftUI
import Firebase

struct MainView: View {
    @State var user: ExpenseUser = ExpenseUser(uid: "", name: "", email: "", transactions: [Transaction]())
    
    var body: some View {
        TabView {
            ExpensesView(transactions: self.$user.transactions)
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            
            AddTransactionView(user: self.$user)
                .tabItem {
                    Label("", systemImage: "plus.app")
                }
        }
        .task {
            let firebase = FirebaseDB()
            user = await firebase.getUser(userID: Auth.auth().currentUser?.uid ?? "")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
