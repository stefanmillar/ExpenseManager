//
//  InsightsView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-28.
//

import SwiftUI

struct InsightsView: View {
    @Binding var user: ExpenseUser
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Insights")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.systemPurple)]), startPoint: .topTrailing, endPoint: .bottomTrailing))
            
            Spacer()
        }
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(user: .constant(ExpenseUser.sample))
    }
}
