//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Stefan Millar on 2022-01-13.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount = ""
    @State private var category = Category.salary
    @State private var date = Date()
    @State private var type = TransactionType.Expense
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @Binding var transactions: [Transaction]
    
    var amountFormatted: Double {
        return (Double(amount) ?? 0) / 100
    }
    
    init(transactions: Binding<[Transaction]>) {
        UITableView.appearance().backgroundColor = .clear
        self._transactions = transactions
    }
    
    var body: some View {
        VStack (spacing: 0) {
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("New Transaction")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.systemPurple)]), startPoint: .topTrailing, endPoint: .bottomTrailing))
            
            
            
            NavigationView {
                Form {
                    
                    Section (header: Text("Amount")) {
                        
                        ZStack(alignment: .leading) {
                            TextField("", text: $amount)
                                .keyboardType(UIKeyboardType.numberPad)
                                .foregroundColor(.clear)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .accentColor(.clear)
                            Text("\(amountFormatted, specifier: "$%.2f")").padding()
                            
                        }
                    }
                    
                    Section {
                        
                        Picker("Category", selection: $category) {
                            ForEach(Category.allCases, id: \.self) { cat in
                                Text(cat.asString)
                            }
                        }
                        
                    }
                    
                    Section {
                        DatePicker(
                            "Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                    }
                    
                    Section {
                        Picker("Type", selection: $type) {
                            ForEach(TransactionType.allCases, id: \.self) { typ in
                                Text(typ.asString)
                            }
                        }
                        
                    }
                    
                    Section {
                        Button(action: NewTransaction) {
                            
                            HStack {
                                Spacer()
                                
                                Label("Create", systemImage: "plus.circle.fill")
                                    .foregroundColor(.green)
                                
                                Spacer()
                            }
                            .padding()
                            
                            
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(UIColor.systemGray4), lineWidth: 3)
                        )
                        
                        
                    }
                    
                }
                .background(Color.white)

            }
            
        }.alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    /**
     Adds a new transaction to the local list and firebase database
     */
    func NewTransaction() {
        let firebase = FirebaseDB()
        
        // Try to add the transaction to the database
        if !firebase.AddTransaction(amount: amountFormatted, date: date, category: category.asString, type: type.asString) {
            
            alertTitle = "Error"
            alertMessage = "Could not add transaction."
        } else {
            
            // Add the new transaction to the local list
            transactions.insert(Transaction(amount: amountFormatted, category: category, date: date, type: type), at: 0)
            
            // Sort the transactions by date
            transactions = transactions.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
            
            // Set alert message
            alertTitle = "Success"
            alertMessage = "Transaction added"
            
            // Reset default values
            amount = ""
            category = Category.salary
            date = Date()
            type = TransactionType.Expense
        }
        
        showAlert = true
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(transactions: .constant(Transaction.sample))
    }
}
