//
//  Color.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/26/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

struct Color {
    var vault: UIColor {
        return UIColor(red: 19/256, green: 133/256, blue: 138/256, alpha: 1.0) // #13858a
    }
    var lightGreen: UIColor {
        return UIColor(red: 12/256, green: 203/256, blue: 139/256, alpha: 1.0) // #0ccb8b
    }
    var error: UIColor {
        return UIColor(red: 255/256, green: 52/256, blue: 52/256, alpha: 1.0) // #ff3434
    }
    var success: UIColor {
        return UIColor(red: 103/256, green: 201/256, blue: 211/256, alpha: 1.0) // #67C9D3
    }
    var separatorGray: UIColor {
        return UIColor(red: 228/256, green: 232/256, blue: 232/256, alpha: 1.0) // #e4e8e8
    }
    var availableStatus: UIColor {
        return UIColor(red: 0/256, green: 255/256, blue: 0/256, alpha: 1.0) // #00ff00
    }
    var lostStatus: UIColor {
        return UIColor(red: 255/256, green: 96/256, blue: 0/256, alpha: 1.0) // #ff6000
    }
    var stolenStatus: UIColor {
        return UIColor(red: 253/256, green: 21/256, blue: 21/256, alpha: 1.0) // #fd1515
    }
    var navigation: UIColor {
        return UIColor(red: 49/256, green: 71/256, blue: 80/256, alpha: 1.0)
    }
    var textInput: UIColor {
        return UIColor(red: 99/256, green: 111/256, blue: 118/256, alpha: 1.0)
    }
}
