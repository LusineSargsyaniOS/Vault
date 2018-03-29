//
//  LoginViewController.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/22/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

final class LoginViewController: BackgroundImagedViewController<LoginViewModel>, UnderlinedTextFieldDelegate, Themed {
    // Configuration
    override open var shouldReactOnEmptySpaceTap: Bool { return true }

    @IBOutlet weak var loginButton: RoundedButton! {
        didSet {
            loginButton.configure()
            loginButton.backgroundColor = theme.colors.lightGreen
            loginButton.setTitle(Text.Authentication.login, for: .normal)
            loginButton.titleLabel?.font = theme.fonts.dejaVuSans(size: Device.isPad ? 23.5 : 13.5)
        }
    }
    @IBOutlet weak var registrationButton: RoundedButton! {
        didSet {
            registrationButton.configure()
            registrationButton.backgroundColor = UIColor.clear
            let signUpTitle =  NSAttributedString(string: Text.Authentication.signup,
                                                  attributes: [NSAttributedStringKey.underlineStyle : 1,
                                                               NSAttributedStringKey.foregroundColor: UIColor.white,  NSAttributedStringKey.font: theme.fonts.dejaVuSans(size: Device.isPad ?  23.5 : 13.5) ?? 13.5])
            registrationButton.setAttributedTitle(signUpTitle, for: .normal)
        }
    }
    @IBOutlet weak var userNameTextField: UnderlinedTextField! {
        didSet {
            userNameTextField.delegate = self
            userNameTextField.attributedPlaceholder = NSAttributedString(string: Text.Authentication.email,
                                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
    }
    @IBOutlet weak var passwordTextField: UnderlinedTextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.isSecureTextEntry = true
            passwordTextField.attributedPlaceholder = NSAttributedString(string: Text.Authentication.password,
                                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
    }

    override open func setupSuccessHandling() {
        viewModel?.successHandler = { [weak self] _ in
            // open Menu
            let profile = ViewControllerProvider.profile(with: self?.viewModel)
            let userItems = ViewControllerProvider.userItems
            let menuViewController = MenuViewController()

            menuViewController.profileViewController = profile
            menuViewController.contentViewController = userItems

            self?.present(menuViewController, animated: true, completion: { [weak self] in
                self?.viewModel?.resetCredentials()

                [self?.userNameTextField,
                 self?.passwordTextField].forEach { $0?.text = "" }
            })
        }
    }

    @IBAction func loginAction(_ sender: RoundedButton) {
        guard let viewModel = viewModel else { return }

        view.endEditing(true)

        let validationState = viewModel.validateCredentials()

        var validTextFields: [UnderlinedTextField] = []
        var inValidTextFields: [UnderlinedTextField] = []

        switch validationState {
        case .valid:
            inValidTextFields = []
            validTextFields = [userNameTextField, passwordTextField]
            viewModel.login()
        case .allEmpty:
            inValidTextFields = [userNameTextField, passwordTextField]
            validTextFields = []
        case .emailEmpty:
            inValidTextFields = [userNameTextField]
            validTextFields = [passwordTextField]
        case .passwordEmpty:
            inValidTextFields = [passwordTextField]
            validTextFields = [userNameTextField]
        }

        inValidTextFields.forEach { $0.state = .empty }
        validTextFields.forEach { $0.state = .valid }
    }

    @IBAction func registerAction(_ sender: RoundedButton) {
        if let viewController = ViewControllerProvider.registration {
            self.present(viewController, animated: true, completion: nil)
        }
    }

    // MARK: UnderlinedTextFieldDelegate
    func textFieldDidEndEditing(_ textField: UnderlinedTextField) {
        switch textField {
        case userNameTextField:
            viewModel?.email = userNameTextField.text ?? ""
        case passwordTextField:
            viewModel?.password = passwordTextField.text ?? ""
        default: break
        }
    }

    func textFieldShouldReturn(_ textField: UnderlinedTextField) -> Bool {
        view.endEditing(true)

        return true
    }
}

