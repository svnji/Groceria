//
//  ProductDataService.swift
//  Groceria
//
//  Created by Daddy on 30/03/2026.
//

import Foundation
import Combine



class ProductDataService {
    
    @Published var allProducts: [ProductModel] = []
    var productSubscription: AnyCancellable?
    
    init() {
        getProducts()
    }
    
    
    // MARK: - get request using combine

    private func getProducts() {
        
        guard let url = URL(string: "https://alhebafruits.com/api/products") else { return }
        
        productSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let respose = output.response as? HTTPURLResponse, respose.statusCode >= 200 && respose.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            // REVIEW:
            // The endpoint does NOT return a bare `[ProductModel]`.
            // It returns an envelope like:
            // { "status": "...", "message": "...", "data": { "data": [ ... ] } }
            // [USER WRONG IDEA] decoding directly as `[ProductModel]` => decode fails => `allProducts` stays empty => nothing appears.
            // [CURSOR FIX] decode the envelope first, then extract the nested `data.data`.
            .decode(type: ProductsAPIResponse.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("ProductDataService decode error:", error)
                }
            } receiveValue: { [weak self] response in
                // REVIEW: `response.data?.data` is the actual `[ProductModel]` list.
                self?.allProducts = response.data?.data ?? []
                self?.productSubscription?.cancel()
            }

    }
    
}
