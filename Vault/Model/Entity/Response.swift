//
//  Response.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

struct Response<T: Decodable>: Decodable {
    var status: Bool
    var message: String
    var result: T?
}
