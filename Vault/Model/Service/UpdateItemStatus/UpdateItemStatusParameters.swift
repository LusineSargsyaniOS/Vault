//
//  UpdateItemStatusParameters.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/28/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct UpdateItemStatusParameters: Routing {
    let status: Int
    let userId: String
    let securityPin: String
    let itemId: String

    // MARK: - Routing
    var path: String {
        return String(format: Text.URLPaths.updateItem, itemId)
    }
    var method: HTTPMethod { return .PUT }
    var parameters: [String : Any]? {
        return [Text.Params.status: status,
                Text.Params.userId: userId,
                Text.Params.securityPin: securityPin]
    }
}
