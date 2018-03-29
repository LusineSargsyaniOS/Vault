//
//  ErrorView.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/2/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class ErrorView: UIView, Themed {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var errorTitleLabel: UILabel!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet private weak var retryButton: RoundedButton! {
        didSet {
            retryButton.configure()
            retryButton.backgroundColor = theme.colors.lightGreen
            retryButton.setTitle(Text.Error.retry, for: .normal)
            retryButton.titleLabel?.font = theme.fonts.dejaVuSans(size: Device.isPad ? 26.5 : 16.5)
        }
    }

    var retryHandler: (()-> Void)?

    var errorTitle: String? {
        set { errorTitleLabel.text = newValue }
        get { return errorTitleLabel.text }
    }

    var errorMessage: String? {
        set { errorMessageLabel.text = newValue }
        get { return errorMessageLabel.text }
    }

    @IBAction private func retryAction(_ sender: UIButton) {
        retryHandler?()
    }
}
