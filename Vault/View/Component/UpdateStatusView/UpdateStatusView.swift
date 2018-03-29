//
//  UpdateStatusView.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/5/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class UpdateStatusView: UIView, Themed {
    @IBOutlet private var statusRoundViews: [UIView]!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var descriptionTextView: UITextView!

    @IBOutlet private weak var availableStatusView: UIView!
    @IBOutlet private weak var availableStatusLabel: UILabel!
    @IBOutlet private weak var lostStatusView: UIView!
    @IBOutlet private weak var lostStatusLabel: UILabel!
    @IBOutlet private weak var stolenStatusView: UIView!
    @IBOutlet private weak var stolenStatusLabel: UILabel!

    var statusUpdatedHandler: ((ItemStatus?) -> Void)?
    var closeButtonHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        availableStatusLabel.text = Text.Status.available
        lostStatusLabel.text = Text.Status.lost
        stolenStatusLabel.text = Text.Status.stolen
        descriptionTextView.text = Text.Status.info

        availableStatusView.backgroundColor = theme.colors.availableStatus
        lostStatusView.backgroundColor = theme.colors.lostStatus
        stolenStatusView.backgroundColor = theme.colors.stolenStatus

        contentView.addShadow()
        statusView.layer.cornerRadius = 5
        statusRoundViews.forEach { $0.layer.cornerRadius = Device.isPad ? 10 : 5 }
    }

    @IBAction func closeAction(_ sender: Any) {
        closeButtonHandler?()
    }

    @IBAction func changeStatus(_ sender: UIButton) {
        statusUpdatedHandler?(ItemStatus(rawValue: sender.tag))
    }
}
