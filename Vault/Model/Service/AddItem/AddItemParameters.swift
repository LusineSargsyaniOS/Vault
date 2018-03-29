//
//  AddItemParameters.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct AddItemParameters: Routing {
    let status: Int
    let category: Int
    let article: Int
    let serialNumber: String
    let userId: String
    let securityPin: String

    // MARK: - Routing
    var method: HTTPMethod { return .POST }
    var path: String { return Text.URLPaths.addItem }
    var parameters: [String : Any]? {
        return [Text.Params.status: status,
                Text.Params.category: category,
                Text.Params.article: article,
                Text.Params.serialNumber: serialNumber,
                Text.Params.userId: userId,
                Text.Params.securityPin: securityPin]}
}
