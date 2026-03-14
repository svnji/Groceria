//
//  HomeTabViewPage.swift
//  Groceria
//
//  Created by Daddy on 10/03/2026.
//

import SwiftUI

struct HomeTabViewPage: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.thirdApp)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(.horizontal)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Fresh groceries with fast delivery your door")
                        .font(.custom("PlusJakartaSans-Bold", size: 20))
                        .multilineTextAlignment(.leading)
                        .padding()
                    Text("Shop Now")
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.primaryApp)
                        )
                        .padding(.horizontal)
                    
                }
                .padding()
                
                Image("HomeTabViewImage")
                    .scaledToFit()
                    .offset(y: -10)
            }
            
        }
    }
}

#Preview {
    HomeTabViewPage()
}
