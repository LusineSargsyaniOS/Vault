//
//  SearchItemParameters.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/28/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct SearchItemParameters: Routing {
    let accountId: String
    let serialNumber: String

    // MARK: - Routing
    var path: String {
        return Text.URLPaths.items
    }
    var parameters: [String : Any]? {
        return [Text.Params.accountId: accountId,
                Text.Params.serialNumber: serialNumber]
    }
}
