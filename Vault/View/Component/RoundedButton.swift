//
//  RoundedButton.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/22/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

final class RoundedButton: UIButton {
    func configure() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
