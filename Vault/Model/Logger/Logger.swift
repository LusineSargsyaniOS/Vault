//
//  Logger.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct Logger {
    static func logString(string: String) {
        print("❌ ERROR: \(string)")
    }

    static func logError(error: Error) {
        print("❌ ERROR: \(error.localizedDescription)")
    }

    static func logSuccess(result: Any?) {
        print("✅ SUCCESS: \(result ?? "")")
    }
}
