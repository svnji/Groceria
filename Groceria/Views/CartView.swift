//
//  CartView.swift
//  Groceria
//
//  Created by Daddy on 15/04/2026.
//

import SwiftUI
 
struct CartView: View {
 
    @EnvironmentObject var cart: CartManager
 
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if cart.isLoading && cart.items.isEmpty {
                    ProgressView()
                        .padding(.top, 40)
                } else if cart.items.isEmpty {
                    Text("Your cart is empty")
                        .padding(.top, 20)
                } else {
                    ForEach(cart.items) { item in
                        CartItemView(item: item)
                    }
                }
            }
            .padding()
        }
        .task {
            await cart.sync()
        }
    }
}
 
// MARK: - CartItemView
 
struct CartItemView: View {
 
    let item: CartItem
    @EnvironmentObject var cart: CartManager
 
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
 
            AsyncImage(url: item.product.resolvedImageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                        .foregroundStyle(.gray)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 72, height: 72)
            .background(Color.secondaryApp)
            .clipShape(RoundedRectangle(cornerRadius: 12))
 
            VStack(alignment: .leading, spacing: 8) {
                Text(item.product.name ?? "Unknown")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .lineLimit(2)
 
                Text(item.product.displayPrice)
                    .font(.custom("PlusJakartaSans-Bold", size: 14))
 
                HStack(spacing: 12) {
                    Button {
                        cart.decrease(item: item)
                    } label: {
                        Image(systemName: "minus")
                    }
 
                    Text(item.quantity)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 13))
                        .frame(minWidth: 20)
 
                    Button {
                        cart.increase(item: item)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .buttonStyle(.plain)
            }
 
            Spacer()
 
            Button {
                cart.remove(item: item)
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
 
#Preview {
    CartView()
        .environmentObject(CartManager())
}
