//
//  ContentView.swift
//  Groceria
//
//  Created by Daddy on 26/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom("PlusJakartaSans-ExtraLight", size: 20))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
