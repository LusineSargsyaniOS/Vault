//
//  UIBarButtonItem+Extension.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/7/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func button(with image: UIImage, target: AnyObject, action: Selector, size: CGSize = CGSize(width: 28, height: 28)) -> UIBarButtonItem {
        let button = UIButton(type: .custom)

        if #available(iOS 10.0, *) {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        } else {
            button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }

        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: button)
        barButton.action = action
        barButton.target = target

        return barButton
    }
}
