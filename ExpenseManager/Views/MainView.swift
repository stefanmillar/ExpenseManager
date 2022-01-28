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
    
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        
        TabView() {
            ExpensesView(transactions: self.$user.transactions)
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            
            AddTransactionView(user: self.$user)
                .tabItem {
                    Label("", systemImage: "plus.app")
                }
            
            ProfileView(user: self.$user, isAuthenticated: self.$isAuthenticated)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            InsightsView(user: self.$user)
                .tabItem {
                    Label("Insights", systemImage: "chart.line.uptrend.xyaxis")
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
        MainView(isAuthenticated: .constant(true))
    }
}
