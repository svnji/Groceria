//
//  CartModel.swift
//  Groceria
//
//  Created by Daddy on 17/04/2026.
//

import Foundation
import SwiftUI

struct CartResponse: Codable {
    let status: String
    let message: String
    let data: CartData
}


struct CartData: Codable {
    let data: [CartItem]
    let cartId: Int
    let cartTotal: String
    let cartCount: Int
    
    enum CodingKeys: String, CodingKey {
        case data
        case cartId = "cart_id"
        case cartTotal = "cart_total"
        case cartCount = "cart_count"
    }
}


struct CartItem: Codable, Identifiable {
    let id: Int
    let productId: Int
    let quantity: String
    let totalPrice: String
    let product: ProductModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case quantity = "amount"
        case totalPrice = "total_price"
        case product
    }
}
