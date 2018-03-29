//
//  NetworkManager.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

final class NetworkManager {
    func execute(routing: Routing, success: @escaping ((Data) -> Void), error: @escaping ((Error) -> Void)) {
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        guard let urlRequest = routing.urlRequest else { return }
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, errorResponse) in
            // check for any errors
            guard errorResponse == nil else {
                #if DEV
                    Logger.logError(error: errorResponse!)
                #endif
                error(errorResponse!)
                
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                #if DEV
                    Logger.logString(string: "Data does not exist")
                #endif

                return
            }

            success(responseData)
        }
        
        task.resume()
    }
}
