//
//  TransactionView.swift
//  Expenses
//
//  Created by Stefan Millar on 2022-01-10.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 4)
                .shadow(color: Color.black, radius: 1, x: 1, y: 1)
            
            HStack {
                Image(systemName: transaction.category.asIcon.icon)
                    .resizable()
                    .foregroundColor(Color(UIColor.systemGray5))
                    .background(transaction.category.asIcon.background)
                    .clipShape(Circle())
                    .scaledToFit()
                    .frame(width: 44.7, height: 44.7)
                    .accessibilityLabel(transaction.category.asString)
                
                VStack (spacing: 10) {
                    Text(transaction.category.asString)
                    Text(transaction.date.formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: Date.FormatStyle.TimeStyle.shortened))
                        .font(.caption)
                }
                Spacer()
                
                if transaction.type == TransactionType.Expense {
                    Text(String(format: "- $%.02f", transaction.amount))
                }
                else {
                    Text(String(format: "$%.02f", transaction.amount))
                }
            }.padding()
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var transaction = Transaction.sample[9]
    static var previews: some View {
        TransactionView(transaction: transaction)
    }
}
