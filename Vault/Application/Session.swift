//
//  File.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/4/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct Session {
    static var login: Login?
    static var ownedItemsCount: Int?

    static func kill() {
        self.login = nil
        self.ownedItemsCount = nil
    }
}
