//
//  AuthView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-19.
//

import SwiftUI

struct AuthView: View {
    @State var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            MainView()
        } else {
            SignInView(isAuthenticated: $isAuthenticated)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
