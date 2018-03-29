//
//  DropDownCell.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/8/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class DropDownCell: UITableViewCell {
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var valueLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        statusView.layer.cornerRadius = 7.5
    }

    func setup(with model: DropDownCellModel) {
        var showStatus = false

        if let status = model.status {
            showStatus = true
            statusView.backgroundColor = status.statusColor
            valueLabel.text = model.title ?? status.text
        } else {
            valueLabel.text = model.title
        }

        statusViewWidthConstraint.constant = showStatus ? 15 : 0
        valueLabelLeadingConstraint.constant = showStatus ? 15 : 0
        statusView.isHidden = !showStatus
    }
}
