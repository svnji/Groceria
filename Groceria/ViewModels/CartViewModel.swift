
//
//  CartViewModel.swift
//  Groceria
//
//  Created by Daddy on 17/04/2026.
//



import Foundation

@MainActor
final class CartViewModel: ObservableObject {

    @Published var items: [CartItem] = []
    @Published var cartTotal: String = ""
    @Published var isLoading = false

    func loadCart() async {

        isLoading = true
        defer { isLoading = false }

        do {
            let cart = try await CartService.shared.fetchCart()
            self.items = cart.data
            self.cartTotal = cart.cartTotal
        } catch {
            print("Cart load error:", error)
        }
    }

    func add(productId: Int) async {

        do {
            try await CartService.shared.addToCart(productId: productId)
            await loadCart()
        } catch {
            print("Add to cart error:", error)
        }
    }

    func increase(item: CartItem) async {
        guard let productId = item.product.id else { return }
        await add(productId: productId)
    }

    func decrease(item: CartItem) async {
        guard let productId = item.product.id else { return }
        guard let currentQty = Int(item.quantity), currentQty > 0 else { return }

        do {
            if currentQty == 1 {
                try await CartService.shared.removeFromCart(cartItemId: item.id)
            } else {
                try await CartService.shared.setQuantity(productId: productId, amount: currentQty - 1)
            }
            await loadCart()
        } catch {
            print("Decrease cart error:", error.localizedDescription)
        }
    }

    func remove(item: CartItem) async {
        do {
            try await CartService.shared.removeFromCart(cartItemId: item.id)
            await loadCart()
        } catch {
            print("Remove cart error:", error.localizedDescription)
        }
    }
}
