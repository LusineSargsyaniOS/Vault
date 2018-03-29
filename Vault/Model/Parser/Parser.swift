//
//  Parser.swift
//  Routing
//
//  Created by Lusine Sargsyan on 2/20/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

func parse<T: Codable>(data: Data) throws -> T {
    let jsonDecoder = JSONDecoder()
    
    do {
        let decodedLog = try jsonDecoder.decode(T.self, from: data)

        #if DEV
            Logger.logSuccess(result: decodedLog)
        #endif

        return decodedLog
    } catch {
        #if DEV
            Logger.logError(error: error)
        #endif

        throw error
    }
}
