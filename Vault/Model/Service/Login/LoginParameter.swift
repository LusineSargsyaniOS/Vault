//
//  LoginParameter.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct LoginParameter: Routing {
    let email: String
    let password: String

    // MARK: - Routing
    var path: String { return Text.URLPaths.login }
    var method: HTTPMethod { return .POST }
    var parameters: [String: Any]? {
        return [Text.Params.email: email,
                Text.Params.password: password]
    }
}
