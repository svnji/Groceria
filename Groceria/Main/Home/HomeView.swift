//
//  HomeView.swift
//  Groceria
//
//  Created by Daddy on 09/03/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State var currentPage = 0
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                
                HStack {
                    Image("profilePic")
                    
                    VStack {
                        Text("Welcom Back")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                            .foregroundStyle(.grayScale70)
                        
                        Text("Vicky Gulgowski")
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
                
                VStack {
                    HStack {
                        Text("Categories")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        
                        Spacer()
                        
                        Button {
                        } label: {
                            Text("See All")
                                .foregroundStyle(.primaryApp)
                                .font(.custom("PlusJakartaSans-Medium", size: 12))
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack(spacing: 22) {
                        ItemView(imageName: "Vegetables", name: "Vegetables")
                        ItemView(imageName: "Fruits", name: "Fruits")
                        ItemView(imageName: "Meat", name: "Meat")
                        ItemView(imageName: "Dairy", name: "Dairy")
                    }
                }
                
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
                        ForEach(0..<10) { _ in
                            BestSellerItemView()
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .padding(.vertical)
        }
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
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12) .frame(width: 154, height: 146)
                
                Image("EurekaLemon")
            }
            
            VStack(alignment: .leading) {
                Text("Eureka Lemon")
                    .font(.custom("PlusJakartaSans-Medium", size: 16))
                
                Text("145 Sold")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundStyle(.grayScale80)
            }
            
            HStack(spacing: 4) {
                Text("$12.00")
                    .font(.custom("PlusJakartaSans-Bold", size: 14))
                
                Text("/Kg")
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
    HomeView()
}
