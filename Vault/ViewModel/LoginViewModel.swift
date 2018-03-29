//
//  LoginViewModel.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

struct LoginViewModelInputs {
    let loginService: LoginService

    init(loginService: LoginService) {
        self.loginService = loginService
    }
}

enum ValidationState {
    case valid
    case allEmpty
    case emailEmpty
    case passwordEmpty

    var message: String? {
        switch self {
        case .valid: return nil
        case .allEmpty: return Text.Error.allEmpty
        case .emailEmpty: return Text.Error.emailEmpty
        case .passwordEmpty: return Text.Error.paswordEmpty
        }
    }
}

final class LoginViewModel: ViewModel<LoginViewModelInputs> {
    var email: String = ""
    var password: String = ""

    var loginInfo: Login?

    func validateCredentials() -> ValidationState {
        var validationState = ValidationState.valid

        switch(email.isEmpty, password.isEmpty) {
        case(true, true):
            validationState = .allEmpty
        case(false, false):
            validationState = .valid
        case(true, false):
            validationState = .emailEmpty
        case(false, true):
            validationState = .passwordEmpty
        }

        if let errorMessage = validationState.message {
            self.errorHandler?(CustomError.validation(message: errorMessage))
        }

        return validationState
    }

    func login() {
        self.retryHandler = { [weak self] in
            self?.login()
        }

        let loginParameters = LoginParameter(email: email,
                                             password: password)

        self.loadingHandler?(true)
        inputs.loginService.call(routing: loginParameters, successHandler: { [weak self] response in
            self?.loadingHandler?(false)

            if response?.status == true {
                // result is received we can go on
                var loginInfo = response?.result
                // Hide sensitive data,
                // NOTE: if we need to use it in the feature implemetations, we should keep it in keychain
                loginInfo?.userName = ""
                // Save login user data in Session
                Session.login = loginInfo
                self?.loginInfo = loginInfo

                self?.hiddingErrorHandler?()
                self?.successHandler?(.login)
            } else {
                self?.loadingHandler?(false)
                self?.errorHandler?(CustomError.service(message: response?.message ?? ""))
            }

        }) { error in
            self.loadingHandler?(false)
            self.errorHandler?(error)
        }
    }

    func resetCredentials() {
        email = ""
        password = ""
    }
}
