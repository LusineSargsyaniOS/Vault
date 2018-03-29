//
//  ItemCell.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/4/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class ItemCell: UITableViewCell, Setupable {
    typealias CellModel = ItemCellModel

    var moreButtonHandler: ((ItemCellModel?) -> Void)? {
        didSet {
            moreButton.isHidden = moreButtonHandler == nil
            moreImageView.isHidden = moreButtonHandler == nil
        }
    }
    
    @IBOutlet private weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = (Device.isPad ? 20 : 15) / 2
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    @IBOutlet private weak var moreImageView: UIImageView!
    
    private var cellModel: CellModel?

    func setup(with cellModel: ItemCellModel) {
        self.cellModel = cellModel

        statusView.backgroundColor = cellModel.statusColor
        titleLabel.text = cellModel.title
    }

    @IBAction func updateStatusAction(_ sender: UIButton) {
        moreButtonHandler?(cellModel)
    }
}
