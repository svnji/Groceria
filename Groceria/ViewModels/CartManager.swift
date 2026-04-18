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

    private let vm = CartViewModel()

    init() {
        Task {
            await sync()
        }
    }

    func sync() async {
        await vm.loadCart()
        self.items = vm.items
        self.total = vm.cartTotal
    }

    func addToCart(productId: Int) {
        Task {
            await vm.add(productId: productId)
            await sync()
        }
    }

    func increase(item: CartItem) {
        Task {
            await vm.increase(item: item)
            await sync()
        }
    }

    func decrease(item: CartItem) {
        Task {
            await vm.decrease(item: item)
            await sync()
        }
    }

    func remove(item: CartItem) {
        Task {
            await vm.remove(item: item)
            await sync()
        }
    }
}
