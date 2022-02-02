//
//  Transaction.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-10.
//

import Foundation

/**
 A struct representation of a transaction
 */
struct Transaction: Identifiable {
    let id: UUID
    var amount: Double
    var category: Category
    var date: Date
    var type: TransactionType
    
    init(id: UUID = UUID(), amount: Double, category: Category, date: Date, type: TransactionType) {
        self.id = id
        self.amount = amount
        self.category = category
        self.date = date
        self.type = type
    }
}

/**
 An enum representing either the expense or income transaction type
 */
enum TransactionType: CaseIterable {
    case Expense
    case Income
    
    case error
    
    var asString: String {
        switch self {
        case .Expense: return "Expense"
        case .Income: return "Income"
        case .error: return "Error"
        }
    }
    
    static func asType(type: String) -> TransactionType {
        switch type {
        case "Expense": return .Expense
        case "Income": return .Income
        default: return .error
        }
    }
}

extension Transaction {
    static let sample: [Transaction] = [
        Transaction(amount: 500.00, category: Category.investmentReturn, date: Date.now, type: TransactionType.Income),
        Transaction(amount: 26.00, category: Category.entertainment, date: Date.now, type: TransactionType.Expense),
        Transaction(amount: 126.34, category: Category.phone, date: Date.now, type: TransactionType.Expense),
        Transaction(amount: 500.00, category: Category.medical, date: Date.now, type: TransactionType.Expense),
        Transaction(amount: 26.00, category: Category.salary, date: Date.now, type: TransactionType.Income),
        Transaction(amount: 126.34, category: Category.bonus, date: Date.now, type: TransactionType.Income),
        Transaction(amount: 500.00, category: Category.car, date: Date.now, type: TransactionType.Expense),
        Transaction(amount: 26.00, category: Category.food, date: Date.now, type: TransactionType.Expense),
        Transaction(amount: 500.00, category: Category.living, date: Date.now, type: TransactionType.Expense)
    ]
}
