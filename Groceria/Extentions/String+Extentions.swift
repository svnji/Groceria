//
//  String+Extentions.swift
//  Groceria
//
//  Created by Daddy on 01/04/2026.
//

import Foundation


extension String {
    
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isValidPassword: Bool {
        self.count >= 8
    }
    
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return self.range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
