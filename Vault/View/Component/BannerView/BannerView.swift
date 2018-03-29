//
//  BannerView.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/1/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

enum BannerViewState: Themed {
    case error
    case success

    var color: UIColor {
        switch self {
        case .error:
            return theme.colors.error
        case .success:
            return theme.colors.success
        }
    }
}

final class BannerView: UIView  {
    @IBOutlet private weak var messageLabel: UILabel!

    var message: String? {
        set {
            messageLabel.text = newValue
        }
        get {
            return messageLabel.text
        }
    }

    var state: BannerViewState? {
        didSet {
            guard let state = state else { return }

            backgroundColor = state.color.withAlphaComponent(0.6)
        }
    }
}
