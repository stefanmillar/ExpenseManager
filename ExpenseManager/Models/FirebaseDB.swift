//
//  FirebaseDB.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-17.
//

import Foundation
import Firebase

/**
 A class to handle all firebase NoSQL database calls
 */
class FirebaseDB {
    private let db = Firestore.firestore()
    
    /**
     Adds a transaction to a specific user in the database
     */
    func addTransaction(amount: Double, date: Date, category: String, type: String, userID: String) -> Bool {
        var ref: DocumentReference? = nil
        var wasAdded = true
        
        ref = db.collection("users").document(userID).collection("transactions").addDocument(data: [
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
    
    /**
     Gets the user information from the database with the given ID
     */
    func getUser(userID: String) async -> ExpenseUser {
        var ref: DocumentReference? = nil
        var user: ExpenseUser = ExpenseUser(uid: "nil", name: "nil", email: "nil", transactions: [Transaction]())
        
        ref = db.collection("users").document(userID)
        
        // Get the snapshot asynchronously
        let document = try? await ref?.getDocument()
        
        if let document = document, document.exists {
            let data = document.data()
            
            // Retrieve general data
            let email = data?["email"] as! String
            let name = data?["name"] as! String
            
            let tranDoc = try? await ref?.collection("transactions").getDocuments()
            
            user = ExpenseUser(uid: userID, name: name, email: email, transactions: [Transaction]())
            
            // Retrieve transactions data
            if !(tranDoc?.isEmpty ?? false) {
                
                // Add the transactions to the local list
                for doc in tranDoc!.documents {
                    let tran = doc.data()
                
                    user.transactions.append(
                        Transaction(amount: tran["amount"] as! Double, category: Category.asCategory(category: tran["category"] as! String), date: (tran["date"] as! Timestamp).dateValue(), type: TransactionType.asType(type: tran["type"] as! String))
                    )
                }
            }
            
            print("User \(userID) found")
        } else {
            print("Error retrieving document")
        }
        
        return user
    }
    
    /**
     Adds a new user to the database
     */
    func createUser(email: String, name: String, userID: String) -> Bool {
        var wasCreated = true
        
        db.collection("users").document(userID).setData([
            "email": email,
            "name": name
        ]) { err in
            if err != nil {
                wasCreated = false
                print("Error creating user")
            } else {
                print("User \(userID) created in database")
            }
            
        }
        
        return wasCreated
    }
}

