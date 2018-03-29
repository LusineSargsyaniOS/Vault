//
//  MappedCategory.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/27/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct MappedCategory {
    let category: Category
    let articles: [Article]

    init(category: Category, articles: [Article]) {
        self.category = category
        self.articles = articles
    }
}
