//
//  ItemsListViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/4/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

class ItemsListViewController<Type: ViewModeling>: TableViewController<Type, ItemCell>, Themed where Type: Datasourced, ItemCell.CellModel == Type.CellModel {

    open var emptyStateText: String { return "" }

    lazy var emptyStateLabel: UILabel = {
        let label =  UILabel()
        label.textAlignment = .center
        label.font = theme.fonts.dejaVuSansExtraLight(size: Device.isPad ? 26.7 : 16.7)
        label.textColor = .white
        label.text = emptyStateText
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Device.isPad ? 75 : 53
    }

    override open func setupEmptyState(show: Bool) {
        emptyStateLabel.isHidden = show
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)

        cell.backgroundColor = cell.contentView.backgroundColor
    }
}
