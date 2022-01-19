//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Stefan Millar on 2022-01-07.
//

import SwiftUI
import Firebase

@main
struct ExpensesManagerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
    
}
