//
//  AuthView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-19.
//

import SwiftUI
import Firebase

struct AuthView: View {
    @State var isAuthenticated = (Auth.auth().currentUser != nil)
    
    var body: some View {
        if isAuthenticated {
            MainView()
        } else {
            NavigationView() {
                SignInView(isAuthenticated: $isAuthenticated)
            }
            .navigationTitle("Log In")
        }
    }
    
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
