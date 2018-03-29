//
//  UnderlinedTextField.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/22/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

enum TextFieldState {
    case valid
    case empty
}

protocol UnderlinedTextFieldDelegate: class {
    func textFieldDidEndEditing(_ textField: UnderlinedTextField)
    func textFieldShouldReturn(_ textField: UnderlinedTextField) -> Bool
}

final class UnderlinedTextField: UIView, Themed, UITextFieldDelegate {
    private let textField = UITextField()
    private let separator = UIView()
    private let errorView = UIView()

    weak var delegate: UnderlinedTextFieldDelegate?

    var text: String? {
        set {
            textField.text = newValue
        }
        get {
            return textField.text
        }
    }
    var attributedPlaceholder: NSAttributedString? {
        set {
            textField.attributedPlaceholder = newValue
        }
        get {
            return textField.attributedPlaceholder
        }
    }
    var isSecureTextEntry: Bool {
        set {
            textField.isSecureTextEntry = newValue
        }
        get {
            return textField.isSecureTextEntry
        }
    }
    var state: TextFieldState? {
        didSet {
            guard let state = state else { return }

            switch state {
            case .empty: emptyeState()
            case .valid: validState()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configure()
    }

    private func configure() {
        setSeparator()
        setTextField()
        setErrorView()

        state = .valid
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        separator.backgroundColor = theme.colors.vault
        state = .valid
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        separator.backgroundColor = theme.colors.separatorGray
        state = (text ?? "").isEmpty ? .empty : .valid
        delegate?.textFieldDidEndEditing(self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn(self) ?? false
    }

    // MARK: Setup UI
    private func setSeparator() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = theme.colors.separatorGray
        self.addSubview(separator)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[separator]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["separator": separator]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separator(1)]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["separator": separator]))
    }

    private func setTextField() {
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = theme.fonts.dejaVuSansCondensedOblique(size: Device.isPad ? 23 : 13)
        textField.textColor = theme.colors.textInput
        textField.tintColor = theme.colors.textInput
        self.addSubview(textField)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(8)-[textField]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["textField": textField]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[textField]-(0)-[separator]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["textField": textField, "separator": separator]))
    }

    private func setErrorView() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.backgroundColor = theme.colors.error
        self.addSubview(errorView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[errorView(4)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["errorView": errorView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[errorView(height)]-(3)-[separator]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height": Device.isPad ? 27.0 : 12], views: ["errorView": errorView, "separator": separator]))
    }

    // MARK: State methods
    private func emptyeState() {
        errorView.isHidden = false
    }

    private func validState() {
        errorView.isHidden = true
    }
}
