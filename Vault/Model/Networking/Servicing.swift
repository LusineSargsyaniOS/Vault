//
//  Servicing.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case unReachable
    case service(message: String)
    case validation(message: String)
}

protocol Servicing {
    associatedtype ResultType: Decodable

    var networkManager: NetworkManager { get }

    func call(routing: Routing, successHandler: @escaping ((Response<ResultType>?) -> Void), errorHandler: @escaping ((Error) -> Void))
}

extension Servicing {
    var networkManager: NetworkManager { return NetworkManager() }

    func call(routing: Routing, successHandler: @escaping ((Response<ResultType>?) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        #if DEV
            callService(routing: routing, successHandler: successHandler, errorHandler: errorHandler)
        #else
            guard let status = Network.reachability?.status else { return }

            switch status {
            case .unreachable:
                DispatchQueue.main.async {
                    errorHandler(CustomError.unReachable)
                }
            default:
                callService(routing: routing, successHandler: successHandler, errorHandler: errorHandler)
            }
        #endif
    }

    private func callService(routing: Routing, successHandler: @escaping ((Response<ResultType>?) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        networkManager.execute(routing: routing, success: { data in
            do {
                let response: Response<ResultType>? = try parse(data: data)

                if let responseWithResult = response {
                    DispatchQueue.main.async {
                        successHandler(responseWithResult)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorHandler(error)
                }
            }
        }) { error in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
}

