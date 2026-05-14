//
//  CartManager.swift
//  Groceria
//
//  Created by Daddy on 15/04/2026.
//

import Foundation
 
@MainActor
final class CartManager: ObservableObject {
 
    @Published var items: [CartItem] = []
    @Published var total: String = ""
    @Published var isLoading = false
 
    init() {
        Task { await sync() }
    }
 
    // MARK: - Sync
 
    func sync() async {
        isLoading = true
        defer { isLoading = false }
 
        do {
            let cart = try await CartService.shared.fetchCart()
            self.items = cart.data
            self.total = cart.cartTotal
        } catch {
            print("Cart sync error:", error)
        }
    }
 
    // MARK: - Add (from product screen)
 
    func addToCart(productId: Int, productChildId: Int? = nil) {
        Task {
            do {
                try await CartService.shared.addToCart(productId: productId, productChildId: productChildId)
                await sync()
            } catch {
                print("Add to cart error:", error)
            }
        }
    }
 
    // MARK: - Increase
 
    func increase(item: CartItem) {
        Task {
            do {
                try await CartService.shared.addToCart(
                    productId: item.productId,
                    productChildId: item.productChildId
                )
                await sync()
            } catch {
                print("Increase error:", error)
            }
        }
    }
 
    // MARK: - Decrease
 
    func decrease(item: CartItem) {
        Task {
            guard let qtyDouble = Double(item.quantity), qtyDouble > 0 else {
                print(" decrease: could not parse quantity '\(item.quantity)'")
                return
            }
            let currentQty = Int(qtyDouble)
 
            do {
                if currentQty <= 1 {
                    try await CartService.shared.removeFromCart(cartItemId: item.id)
                } else {
                    try await CartService.shared.setQuantity(
                        productId: item.productId,
                        productChildId: item.productChildId,
                        amount: Double(currentQty - 1)
                    )
                }
                await sync()
            } catch {
                print("Decrease error:", error)
            }
        }
    }
 
    // MARK: - Remove
 
    func remove(item: CartItem) {
        Task {
            do {
                try await CartService.shared.removeFromCart(cartItemId: item.id)
                await sync()
            } catch {
                print("Remove error:", error)
            }
        }
    }
}
