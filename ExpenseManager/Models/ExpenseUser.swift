//
//  ExpenseUser.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-21.
//

import Foundation
import Firebase

struct ExpenseUser {
    var uid: String
    var name: String
    var email: String
    var transactions: [Transaction]
}

extension ExpenseUser {
    static let sample: ExpenseUser = ExpenseUser(uid: "123", name: "Test Name", email: "testemail@email.com", transactions: Transaction.sample)
}
