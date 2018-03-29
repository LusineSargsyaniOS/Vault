//
//  UIView+Extension.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/27/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

extension UIView {
    static func loadNib<T>() -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        let nib = UINib(nibName: nibName, bundle: bundle)

        return nib.instantiate(withOwner: self, options: nil).first as? T
    }

    func addInto(superView: UIView, with edge: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)

        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: edge.top))
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: edge.bottom))
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: edge.left))
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1, constant: edge.right))
    }

    var heightConstraint: NSLayoutConstraint? {
        if let constraint = self.constraints.filter ({ $0.firstAttribute == .height }).first {
            return constraint
        }

        return nil
    }
    
    func addShadow(size: CGSize = CGSize(width: -1, height: 1), shadowRadius: CGFloat = 5.0, shadowOpacity: Float = 0.5, shadowColor: UIColor = UIColor.black) {
        layer.masksToBounds = false
        layer.shadowOffset = size
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
    }

    func removeShadow() {
        layer.masksToBounds = true
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.0
        layer.shadowColor = UIColor.clear.cgColor
    }
}
