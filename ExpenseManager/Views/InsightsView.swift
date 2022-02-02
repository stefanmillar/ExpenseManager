//
//  InsightsView.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-28.
//

import SwiftUI
import SwiftPieChart

struct InsightsView: View {
    @Binding var user: ExpenseUser
    
    var expenseData: Dictionary<String, Double> {
        var data = Dictionary<String, Double>()
        
        data[Category.car.asString] = 0.0
        data[Category.entertainment.asString] = 0.0
        data[Category.food.asString] = 0.0
        data[Category.living.asString] = 0.0
        data[Category.medical.asString] = 0.0
        data[Category.phone.asString] = 0.0
        
        for trans in self.user.transactions {
            if trans.type == TransactionType.Expense {
                data[trans.category.asString]? += trans.amount
            }
        }
        
        return data
    }
    
    var incomeData: Dictionary<String, Double> {
        var data = Dictionary<String, Double>()
        
        data[Category.salary.asString] = 0.0
        data[Category.investmentReturn.asString] = 0.0
        data[Category.bonus.asString] = 0.0
        
        for trans in self.user.transactions {
            if trans.type == TransactionType.Income {
                data[trans.category.asString]? += trans.amount
            }
        }
        
        return data
    }
    
    init(user: Binding<ExpenseUser>) {
        UITableView.appearance().backgroundColor = .clear
        self._user = user
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.white)]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: {
                            ZStack {
                                
                                LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.white)]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                                    .ignoresSafeArea()
                                
                                if isIncomeEmpty() {
                                    Text("Add an income transaction to see insights")
                                        .foregroundColor(Color.white)
                                        .font(Font.largeTitle)
                                        .padding()
                                } else {
                                    
                                    PieChartView(values: Array(incomeData.values),
                                                 names: Array(incomeData.keys),
                                                 formatter: {value in String(format: "$%.2f", value)},
                                                 colors: [Color.red, Color.green, Color.blue],
                                                 backgroundColor: .clear).padding()
                                    
                                }
                            }.navigationTitle("Income")
                        }, label: {
                            HStack {
                                Text("Income")
                                Image(systemName: "chevron.right")
                            }
                        }).padding(.trailing, 10)
                        
                        Spacer()
                    }
                }
                
                
                if isExpenseEmpty() {
                    Text("Add an expense transaction to see insights")
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                        .padding()
                    
                } else {
                    PieChartView(values: Array(expenseData.values),
                                 names: Array(expenseData.keys),
                                 formatter: {value in String(format: "$%.2f", value)},
                                 colors: [Color.red, Color.green, Color.blue, Color.black, Color.cyan, Color.brown, Color.indigo],
                                 backgroundColor: .clear)
                        .padding()
                }
            }.navigationTitle("Expenses")
        }
    }
    
    func isExpenseEmpty() -> Bool {
        if expenseData[Category.car.asString] == 0.0 &&
            expenseData[Category.entertainment.asString] == 0.0 &&
            expenseData[Category.food.asString] == 0.0 &&
            expenseData[Category.living.asString] == 0.0 &&
            expenseData[Category.medical.asString] == 0.0 &&
            expenseData[Category.phone.asString] == 0.0 {
            return true
        }
        
        return false
    }
    
    func isIncomeEmpty() -> Bool {
        if incomeData[Category.salary.asString] == 0.0 && incomeData[Category.investmentReturn.asString] == 0.0 && incomeData[Category.bonus.asString] == 0.0 {
            return true
        }
        
        return false
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(user: .constant(ExpenseUser.sample))
    }
}
