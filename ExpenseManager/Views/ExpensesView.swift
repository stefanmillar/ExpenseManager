//
//  ContentView.swift
//  Expenses
//
//  Created by Stefan Millar on 2022-01-07.
//

import SwiftUI

struct ExpensesView: View {
    
    @Binding var transactions: [Transaction]
    
    var expenseTotal: Double {
        var total: Double = 0
        for trans in transactions {
            if trans.type == TransactionType.Expense {
                total += trans.amount
            }
        }
        
        return total
    }
    
    var incomeTotal: Double {
        var total: Double = 0
        for trans in transactions {
            if trans.type == TransactionType.Income {
                total += trans.amount
            }
        }
        
        return total
    }
    
    var balance: Double {
        return incomeTotal - expenseTotal
    }
    
    var body: some View {
        
        VStack (spacing: 0) {
            
            VStack {
                
                // Balance
                VStack (spacing: 10) {
                    Text("Current Balance")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Text("\(balance, specifier: "$%.2f")")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Text("\(Date().formatted(date: Date.FormatStyle.DateStyle.complete, time: Date.FormatStyle.TimeStyle.omitted))")
                        .font(.caption)
                        .foregroundColor(.white)
                }.padding()
                
                // Income and expenses
                HStack {
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "arrow.up.right").foregroundColor(.green)
                            
                            
                            Text("Income")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        Text("\(incomeTotal, specifier: "$%.2f")")
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                    VStack {
                        
                        HStack {
                            Image(systemName: "arrow.down.left").foregroundColor(.red)
                            Text("Expenses")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        Text("\(expenseTotal, specifier: "$%.2f")")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.systemPurple)]), startPoint: .topTrailing, endPoint: .bottomTrailing))
            
            // List of transactions
            List {
                ForEach (transactions) { trans in
                    TransactionView(transaction: trans)
                }
                .listRowBackground(Color.white)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .padding(.top, 10)
            
            
            Spacer()
        }
        
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(transactions: .constant(Transaction.sample))
    }
}
