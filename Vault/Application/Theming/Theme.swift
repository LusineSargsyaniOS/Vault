//
//  Theme.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/26/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit


protocol Themed {
    var theme: Theme { get }
}

extension Themed {
    var theme: Theme { return Theme.default }
}

struct Theme {
    static let `default`: Theme = Theme()

    let colors: Color = Color()
    let fonts: Font = Font()
}
