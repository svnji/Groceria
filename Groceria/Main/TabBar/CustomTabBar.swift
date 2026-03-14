//
//  CustomTabBar.swift
//  Groceria
//
//  Created by Daddy on 10/03/2026.
//

import SwiftUI

struct CustomTabBar: View {
    
    @State var index = 0
    
    var body: some View {
        ZStack{
            
            if self.index == 0 {
                HomeView()
            } else if self.index == 1 {
                DiscoveryView()
            } else if self.index == 2 {
                ItemsView()
            } else if self.index == 3 {
                MessageView()
            } else if self.index == 4 {
                ProfileView()
            }
        }
        .navigationBarBackButtonHidden(true)
        CustomTaps(index: self.$index)
    }
}

struct CustomTaps: View {
    
    @Binding var index: Int
    
    var body: some View {
        
        HStack {
            
            Button {
                self.index = 0
            } label: {
                Image(systemName: "house.fill")
            }
            .foregroundStyle(Color.primaryApp.opacity(self.index == 0 ? 1 : 0.1))
            Spacer(minLength: 0)

            Button {
                self.index = 1
            } label: {
                Image(systemName: "safari")
            }
            .foregroundStyle(Color.primaryApp.opacity(self.index == 1 ? 1 : 0.3))
            Spacer(minLength: 0)
            
            Button {
                self.index = 2
            } label: {
                Image(systemName: "handbag")
            }
            .foregroundStyle(Color.white.opacity(self.index == 2 ? 1 : 0.3))
            
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.primaryApp)
                    .frame(width: 50, height: 50)
                )

            Spacer(minLength: 0)
            
            Button {
                self.index = 3
            } label: {
                Image(systemName: "paperplane")
            }
            .foregroundStyle(Color.primaryApp.opacity(self.index == 3 ? 1 : 0.3))
            Spacer(minLength: 0)
            
            Button {
                self.index = 4
            } label: {
                Image(systemName: "person")
            }
            .foregroundStyle(Color.primaryApp.opacity(self.index == 4 ? 1 : 0.3))
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(.white)
    }
}

#Preview {
    CustomTabBar()
}
