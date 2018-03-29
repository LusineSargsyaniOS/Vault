//
//  UserItemsParameters.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/27/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct UserItemsParameters: Routing {
    let userId: String

    // MARK: - Routing
    var path: String { return Text.URLPaths.itemsUser }
    var parameters: [String : Any]? {
        return [Text.Params.userId: userId]
    }
}
