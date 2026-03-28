//
//  CategoryView.swift
//  Groceria
//
//  Created by Daddy on 23/03/2026.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            ScrollView {
                Grid(horizontalSpacing: 22, verticalSpacing: 22) {
                    GridRow {
                        ItemView(imageName: "Vegetables", name: "Vegetables")
                        NavigationLink(value: ShopRoute.fruits) {
                            ItemView(imageName: "Fruits", name: "Fruits")
                        }
                        .buttonStyle(.plain)
                        ItemView(imageName: "Meat", name: "Meat")
                        ItemView(imageName: "Dairy", name: "Dairy")
                    }
                    GridRow {
                        ItemView(imageName: "Bakery", name: "Bakery")
                        ItemView(imageName: "Beverages", name: "Beverages")
                        ItemView(imageName: "Snacks", name: "Snacks")
                        ItemView(imageName: "Pantry", name: "Pantry")
                    }
                }
                .padding(.vertical, 35)
                
                HStack {
                    Text("Recommended Products")
                        .font(.custom("PlusJakartaSans-Bold", size: 16))
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Text("See All")
                            .foregroundStyle(.primaryApp)
                            .font(.custom("PlusJakartaSans-Medium", size: 12))
                    }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<10) { _ in
                        RecommendedItemView()
                    }
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        K.BackButtonView()
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
}

struct RecommendedItemView: View {
    
    @State var isFav = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12) .frame(width: 154, height: 146)
                    .foregroundStyle(.secondaryApp)
                
                Image("Croissant")
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(isFav ? .error : .grayScale50)
                    .offset(x: 60, y: -55)
                    .onTapGesture {
                        isFav.toggle()
                    }
            }
            
            VStack(alignment: .leading) {
                Text("Croissant")
                    .font(.custom("PlusJakartaSans-Medium", size: 16))
                
                Text("145 Sold")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundStyle(.grayScale80)
            }
            
            HStack(spacing: 4) {
                Text("$12.00")
                    .font(.custom("PlusJakartaSans-Bold", size: 14))
                
                Text("/pcs")
                    .font(.custom("PlusJakartaSans-Medium", size: 12))
                    .foregroundStyle(.grayScale70)
                
                
                Button {
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.primaryApp)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.secondaryApp)
                        )
                        .offset(x: 45)
                }
            }
        }
    }
}

#Preview {
    CategoryView()
}
