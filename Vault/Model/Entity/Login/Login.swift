//
//  Login.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

/**
  * All properties are optional as in some cases (for example any wrong credential during Auth) we are receive response with nil
  * values for all fields bellow or the fields are absent at all
 */
struct Login: Decodable {
    let userId: String?
    var userName: String?
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let email: String?
    let displayName: String?
    let photoId: String?
    let accountId: String?
    let status: Int?
    let photo: String?
    let errors: [String]?
}
