//
//  HomeViewModel.swift
//  Groceria
//
//  Created by Daddy on 30/03/2026.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allProducts: [ProductModel] = []
    
    private let dataService = ProductDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // REVIEW:
        // ProductDataService fetches products and publishes them via `$allProducts`.
        // HomeViewModel subscribes and republishes into `vm.allProducts`,
        // which is what `HomeView` reads to render the grid.
        dataService.$allProducts
            .sink { [weak self] (retrunedProducts) in
                self?.allProducts = retrunedProducts
            }
            .store(in: &cancellables)
    }
    
}
