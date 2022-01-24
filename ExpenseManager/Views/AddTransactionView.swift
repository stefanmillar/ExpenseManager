//
//  AddTransactionView.swift
//  ExpenseManager
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
    
    @Binding var user: ExpenseUser
    
    var amountFormatted: Double {
        return (Double(amount) ?? 0) / 100
    }
    
    init(user: Binding<ExpenseUser>) {
        UITableView.appearance().backgroundColor = .clear
        self._user = user
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
                                if cat != Category.error {
                                    Text(cat.asString)
                                }
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
                                if typ != TransactionType.error {
                                    Text(typ.asString)
                                }
                            }
                        }
                        
                    }
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.green)
                            .opacity(0.9)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal, 4)
                            .shadow(color: Color.black, radius: 1, x: 1, y: 1)
                        
                        Section {
                            HStack {
                                
                                Button(action: newTransaction) {
                                    Label("Create", systemImage: "plus.circle")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                
                            }
                        }
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
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
    func newTransaction() {
        let firebase = FirebaseDB()
        
        // Try to add the transaction to the database
        if !firebase.addTransaction(amount: amountFormatted, date: date, category: category.asString, type: type.asString, userID: user.uid) {
            
            alertTitle = "Error"
            alertMessage = "Could not add transaction."
        } else {
            
            // Add the new transaction to the local list
            user.transactions.insert(Transaction(amount: amountFormatted, category: category, date: date, type: type), at: 0)
            
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
        AddTransactionView(user: .constant(ExpenseUser.sample))
    }
}
