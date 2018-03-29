//
//  Category.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/26/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

enum CategoryType: Int, Decodable {
    case phones = 10
    case cars = 20
    case watches = 30
    case jewlery = 40
    case computer = 50
    case bicycles = 60

    var stringValue: String {
        return "\(self.rawValue)"
    }
}

struct Category: Decodable {
    let categoryId: CategoryType
    let categoryTitle: String
}

extension Category: Equatable {
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.categoryId == rhs.categoryId
            && lhs.categoryTitle == rhs.categoryTitle
    }
}
