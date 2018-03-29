//
//  UserItem.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/27/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct UserItem: Decodable {
    let itemId: Int
    let owner: String
    let category: Int
    let article: Int
    let serialNumber: String
    var status: Int
}
