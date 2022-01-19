//
//  FirebaseDB.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-17.
//

import Foundation
import Firebase

class FirebaseDB {
    private let db = Firestore.firestore()
    
    func AddTransaction(amount: Double, date: Date, category: String, type: String) -> Bool {
        var ref: DocumentReference? = nil
        var wasAdded = true
        
        do {
            ref = db.collection("users").document("Test").collection("Transactions").addDocument(data: [
                "amount": amount,
                "date": date,
                "category": category,
                "type": type
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    wasAdded = false
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            
            return wasAdded
        }
    }
}

