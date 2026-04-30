//
//  AppRouter.swift
//  Groceria
//
//  Created by Daddy on 25/04/2026.
//

import SwiftUI

final class AppRouter: ObservableObject {
    
    enum Route: Hashable {
        case login
        case register
        case home
        case user
        case newPassword
    }
    
    @Published var path: [Route] = []
    
    func goTo(_ route: Route) {
        path.append(route)
    }
    
    func resetToRoot(_ route: Route) {
        path = [route]
    }
    
    func pop() {
        _ = path.popLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
