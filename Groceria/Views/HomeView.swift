//
//  HomeView.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State var currentPage = 0
    
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                
                // MARK: - Welcoming
                HStack {
                    Image("profilePic")
                    
                    VStack(alignment: .leading) {
                        Text("Welcome Back")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                            .foregroundStyle(.grayScale70)
                        
                        Text("\(firstName) \(lastName)")
                            .font(.custom("PlusJakartaSans-Regular", size: 24))
                    }
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Image(systemName: "bell.badge")
                            .foregroundStyle(.black)
                    }
                }
                .padding(24)
                
                // MARK: - Ads TabView
                VStack {
                    TabView(selection: $currentPage) {
                        HomeTabViewPage().tag(0)
                        HomeTabViewPage().tag(1)
                        HomeTabViewPage().tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 180)
                    
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Capsule()
                                .fill(
                                    index == currentPage
                                    ? Color.primaryApp
                                    : Color.gray.opacity(0.3)
                                )
                                .frame(
                                    width: index == currentPage ? 20 : 6,
                                    height: 6
                                )
                                .animation(.easeInOut, value: currentPage)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // MARK: - Categories
                VStack {
                    HStack {
                        Text("Categories")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        
                        Spacer()
                        
                        NavigationLink(value: ShopRoute.categories) {
                            Text("See All")
                                .foregroundStyle(.primaryApp)
                                .font(.custom("PlusJakartaSans-Medium", size: 12))
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack(spacing: 22) {
                        ItemView(imageName: "Vegetables", name: "Vegetables")
                        NavigationLink(value: ShopRoute.fruits) {
                            ItemView(imageName: "Fruits", name: "Fruits")
                        }
                        .buttonStyle(.plain)
                        ItemView(imageName: "Meat", name: "Meat")
                        ItemView(imageName: "Dairy", name: "Dairy")
                    }
                }
                
                // MARK: - Best Seller
                VStack(spacing: 12) {
                    HStack {
                        Text("Best Seller")
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
                        // REVIEW:
                        // [USER WRONG] Previously this grid used a fixed `0..<10` loop and
                        // showed static `BestSellerItemView()` content, so it couldn't show real products.
                        // [CURSOR FIX] Drive the grid from `vm.allProducts` and show `ProgressView` while loading.
                        if vm.allProducts.isEmpty {
                            ProgressView()
                                .gridCellColumns(2)
                                .padding(.vertical, 24)
                        } else {
                            ForEach(Array(vm.allProducts.enumerated()), id: \.offset) { _, product in
                                // REVIEW: `BestSellerItemView` now receives the API product model.
                                BestSellerItemView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationDestination(for: ShopRoute.self) { route in
            switch route {
            case .categories:
                CategoryView()
            case .fruits:
                FruitsView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ItemView: View {
    
    

    
    var imageName: String
    var name: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.secondaryApp)
                
                Image(imageName)
            }
            
            Text(name)
                .font(.custom("PlusJakartaSans-Medium", size: 12))
                .foregroundStyle(.grayScale90)
        }
    }
}

struct BestSellerItemView: View {
    // REVIEW:
    // Static best-seller UI changed to be dynamic.
    // This view now renders values from the decoded `ProductModel`.
    let product: ProductModel
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 154, height: 146)
                
                Group {
                    if let url = product.resolvedImageURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(8)
                            case .failure:
                                Image("EurekaLemon")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(8)
                            case .empty:
                                ProgressView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image("EurekaLemon")
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text(product.name ?? "Product")
                    .font(.custom("PlusJakartaSans-Medium", size: 16))
                    .lineLimit(2)
                
                // REVIEW:
                // If your API field for "sold" is different than `rate_count`,
                // update this line to use the correct model property.
                if let sold = product.rateCount, sold > 0 {
                    Text("\(sold) Sold")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.grayScale80)
                } else {
                    Text(" ")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                }
            }
            
            HStack(spacing: 4) {
                Text(product.displayPrice)
                    .font(.custom("PlusJakartaSans-Bold", size: 14))
                
                Text("/\(product.unit?.name ?? "Kg")")
                    .font(.custom("PlusJakartaSans-Medium", size: 12))
                    .foregroundStyle(.grayScale70)
                
                Spacer()
                
                Button {
                    if let id = product.id {
                           cart.addToCart(productId: id)
                           print("Added to cart: \(product.name ?? "Unknown")")
                       }
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.primaryApp)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.secondaryApp)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(CartManager())
}
