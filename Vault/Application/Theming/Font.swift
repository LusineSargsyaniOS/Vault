//
//  Font.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/26/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

struct Font {
    func dejaVuSans(size: CGFloat) -> UIFont? {
        return UIFont(name: "DejaVuSans", size: size)
    }

    func dejaVuSansCondensed(size: CGFloat) -> UIFont? {
        return UIFont(name: "DejaVuSansCondensed", size: size)
    }

    func dejaVuSansCondensedOblique(size: CGFloat) -> UIFont? {
        return UIFont(name: "DejaVuSansCondensed-Oblique", size: size)
    }

    func dejaVuSansBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "DejaVuSans-Bold", size: size)
    }

    func dejaVuSansExtraLight(size: CGFloat) -> UIFont? {
        return UIFont(name: "DejaVuSans-ExtraLight", size: size)
    }
}
