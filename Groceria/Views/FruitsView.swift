//
//  FruitsView.swift
//  Groceria
//
//  Created by Daddy on 27/03/2026.
//

import SwiftUI

struct FruitsView: View {
    
    @Environment(\.dismiss) private var dismiss

    @StateObject private var vm = FruitsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            K.AppTextField(title: "", placeHolder: "Search...", text: $vm.searchText)
                
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(vm.categories, id: \.self) { category in
                        FruitsButtonView(
                            text: category,
                            isSelected: vm.selectedCategory == category
                        ) {
                            vm.selectCategory(category)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            
            HStack {
                Text("Recommendation")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 20))
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.top, 8)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(vm.filteredFruits.indices, id: \.self) { index in
                        let fruit = vm.filteredFruits[index]
                        FruitCardView(
                            name: fruit.0,
                            imageName: fruit.1,
                            sold: fruit.2,
                            price: fruit.3
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("Fruits")
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

struct FruitsButtonView: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(isSelected ? Color.primaryApp : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

struct FruitCardView: View {
    let name: String
    let imageName: String
    let sold: String
    let price: String

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 90, height: 90)
                    .foregroundStyle(.secondaryApp)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.custom("PlusJakartaSans-Medium", size: 16))
                
                Text(sold)
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundStyle(.grayScale80)
                
                HStack(spacing: 4) {
                    let priceParts = price.split(separator: " ")
                    Text(priceParts[0])
                        .font(.custom("PlusJakartaSans-Bold", size: 14))
                    if priceParts.count > 1 {
                        Text(priceParts[1])
                            .font(.custom("PlusJakartaSans-Medium", size: 12))
                            .foregroundStyle(.grayScale70)
                    }
                }
            }
            
            Spacer()
            
            Button {
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.primaryApp)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondaryApp)
                    )
            }
        }
    }
}

#Preview {
    FruitsView()
}
