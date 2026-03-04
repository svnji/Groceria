//
//  Constants.swift
//  Groceria
//
//  Created by Daddy on 04/03/2026.
//

import SwiftUI

struct K{
    
    struct AppTextField: View {
        
        @State var title: String
        @State var placeHolder: String
        @Binding var text: String
        var height: CGFloat = 52
        var body: some View {
            VStack(alignment: .leading){
                Text(title)
                    .font(.custom("PlusJakartaSans-Medium", size: 14))
                    .foregroundStyle(.grayScale70)
                    .padding(.horizontal, 24)
                
                
                TextField(placeHolder, text: $text)
                    .frame(height: height)
                    .padding(.horizontal, 24)
                    .background(.secondaryApp)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .foregroundStyle(.grayScale60)
                    .padding()
            }
        }
    }
    
    struct ButtonView: View {
        
        let imageName: String
        let text: String
        let action: () -> Void
        
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Image(imageName)
                    Text(text)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primaryApp)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .padding()
        }
    }
    
    struct BackButtonView: View {
        var body: some View {
            Image(systemName: "arrow.left")
                .foregroundStyle(.black)
                .font(.headline)
                .padding(20)
                .background(.grayScale40)
                .clipShape(Circle())
        }
    }
    
}
