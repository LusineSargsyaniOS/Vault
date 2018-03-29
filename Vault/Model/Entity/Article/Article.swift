///Users/developer/Desktop/Vault/Vault/Vault/Application/Theme.swift
//  Article.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/26/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct Article: Decodable {
    let articleId: Int
    let articleTitle: String
}

extension Article: Equatable {
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.articleId == rhs.articleId
            && lhs.articleTitle == rhs.articleTitle
    }
}

