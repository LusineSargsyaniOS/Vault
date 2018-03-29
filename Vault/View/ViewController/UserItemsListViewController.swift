//
//  UserItemsListViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/3/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class UserItemsListViewController: ItemsListViewController<UserItemsListViewModel> {
    override open var emptyStateText: String { return Text.UserItems.emptyResult }
    override var shouldReactOnEmptySpaceTap: Bool { return true }
    lazy var updateStatusView: UpdateStatusView? = {
        let view: UpdateStatusView? = UpdateStatusView.loadNib()

        view?.closeButtonHandler = { [weak self] in self?.updateStatusView?.removeFromSuperview() }

        return view
    }()

    lazy var refreshControl: UIRefreshControl? = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }

        viewModel?.fetchUserItems()
    }

    override func setupSuccessHandling() {
        viewModel?.successHandler = { [weak self] responseCase in
            guard let strongSelf = self, let responseCase = responseCase else { return }

            switch responseCase {
            case .updateStatus:
                strongSelf.handleGenericSuccess(with: Text.AddItem.successInfo, completion: nil)
            default: break
            }
        }
    }

    override open func setupNavigation() {
        super.setupNavigation()

        title = Text.UserItems.title

        let addButton = UIBarButtonItem.button(with: #imageLiteral(resourceName: "ic_add_item"), target: self, action: #selector(addActionHandler))
        let searchButton = UIBarButtonItem.button(with: #imageLiteral(resourceName: "ic_search"), target: self, action: #selector(searchActionHandler))

        navigationItem.rightBarButtonItems = [addButton, searchButton]
    }

    @objc private func addActionHandler() {
        guard let add = ViewControllerProvider.addItem else { return }

        let navigationController = UINavigationController(rootViewController: add)
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func searchActionHandler() {
        guard let search = ViewControllerProvider.search else { return }

        let navigationController = UINavigationController(rootViewController: search)
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        viewModel?.fetchUserItems()
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)

        if let cell = cell as? ItemCell {
            cell.moreButtonHandler = { [weak self] itemCellModel in
                guard let strongSelf = self else { return }

                strongSelf.updateStatusView?.addInto(superView: strongSelf.view)
                strongSelf.updateStatusView?.statusUpdatedHandler = { statusId in
                    if statusId != itemCellModel?.currentStatus,
                        let statusId = statusId {
                        strongSelf.viewModel?.updateItemStatus(cellModel: itemCellModel, with: statusId)
                    }

                    strongSelf.updateStatusView?.removeFromSuperview()
                }
            }
        }
    }
}
