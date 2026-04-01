//
//  ItemsView.swift
//  Groceria
//
//  Created by Daddy on 10/03/2026.
//

import SwiftUI

struct ItemsView: View {
    
    @StateObject private var vm = ItemsViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            AsyncImage(url: URL(string: vm.user?.avatarUrl ?? "")) { Image in
                Image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundStyle(.secondary)
            }
            .frame(width: 120, height: 120)
            
            Text(vm.user?.login ?? "userName")
                .font(.title3)
                .bold()
            
            Text(vm.user?.bio ?? "Bio")
                .padding()
            
            Spacer()
            
        }
        .padding()
        
        .task {
            await vm.loadUser()
        }
    }

}

#Preview {
    ItemsView()
}
