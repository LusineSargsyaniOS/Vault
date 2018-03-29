//
//  ViewModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/28/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

protocol ViewModeling {
    var loadingHandler: ((Bool) -> Void)? { set get }
    var errorHandler: ((Error) -> Void)? { set get }
    var hiddingErrorHandler: (() -> Void)? { set get }
    // The parameter should be presentation object for controller
    var successHandler: ((ResponseSuccess?) -> Void)? { set get }
    var retryHandler: (() -> Void)? { set get }
}

class ViewModel<Type>: ViewModeling {
    var loadingHandler: ((Bool) -> Void)?
    var errorHandler: ((Error) -> Void)?
    var hiddingErrorHandler: (() -> Void)?
    var successHandler: ((ResponseSuccess?) -> Void)?
    var retryHandler: (() -> Void)?

    let inputs: Type

    init(inputs: Type) {
        self.inputs = inputs
    }
}
