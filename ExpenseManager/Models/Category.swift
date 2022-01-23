//
//  Category.swift
//  ExpenseManager
//
//  Created by Stefan Millar on 2022-01-10.
//

import Foundation
import SwiftUI

/**
 An enum representing a transaction category.
 */
enum Category: CaseIterable {
    
case salary
case bonus
case investmentReturn
    
case food
case entertainment
case living
case investment
case car
case phone
case medical
    
case error
    
    var asString: String {
        switch self {
        case .salary: return "Salary"
        case .bonus: return "Bonus"
        case .investmentReturn: return "Investment Return"
            
        case .food: return "Food"
        case .entertainment: return "Entertainment"
        case .living: return "Living"
        case .investment: return "Investment"
        case .car: return "Car"
        case .phone: return "Phone"
        case .medical: return "Medical"
        case .error: return "Error"
        }
    }
    
    static func asCategory(category: String) -> Category {
        switch category {
        case "Salary": return .salary
        case "Bonus": return .bonus
        case "Investment Return": return .investmentReturn
            
        case "Food": return .food
        case "Entertainment": return .entertainment
        case "Living": return .living
        case "Investment": return .investment
        case "Car": return .car
        case "Phone": return .phone
        case "Medical": return .medical
        default: return .error
        }
    }
    
    var asIcon: (icon: String, background: Color) {
        switch self {
        case .salary:
            return (icon: "dollarsign.circle.fill", background: Color.green)
        case .bonus:
            return (icon: "bahtsign.circle.fill", background: Color.green)
        case .investmentReturn:
            return (icon: "arrow.up.circle.fill", background: Color.black)
        case .food:
            return (icon: "bag.circle.fill", background: Color.blue)
        case .entertainment:
            return (icon: "tv.circle.fill", background: Color.orange)
        case .living:
            return (icon: "house.circle.fill", background: Color.purple)
        case .investment:
            return (icon: "arrow.down.circle.fill", background: Color.red)
        case .car:
            return (icon: "car.circle.fill", background: Color.gray)
        case .phone:
            return (icon: "phone.circle.fill", background: Color.brown)
        case .medical:
            return (icon: "heart.circle.fill", background: Color.red)
        case .error:
            return (icon: "xmark.octagon.fill", background: Color.red)
        }
    }
}
