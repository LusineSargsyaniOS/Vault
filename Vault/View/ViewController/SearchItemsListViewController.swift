//
//  SearchItemsListViewController.swift.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/5/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class SearchItemsListViewController: ItemsListViewController<SearchItemsListViewModel>, UISearchBarDelegate {
    override open var shouldReactOnEmptySpaceTap: Bool { return true }
    override open var emptyStateText: String { return Text.Search.emptyResult }

    private let searchBar = UISearchBar()

    override open func setupNavigation() {
        super.setupNavigation()

        searchBar.delegate = self
        searchBar.placeholder = Text.Search.searchPlaceholder
        self.navigationItem.titleView = searchBar

        let close = UIBarButtonItem.button(with: #imageLiteral(resourceName: "ic_clear_white_48px"), target: self, action: #selector(closeSearch))
        navigationItem.leftBarButtonItem = close
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)

        (cell as? ItemCell)?.moreButtonHandler = nil
    }

    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel?.searchItem(serialNumber: searchBar.text)
    }

    @objc private func closeSearch() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let dataSource = viewModel?.dataSource,  dataSource.count != 0 else { return 0 }

        return 40
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel?.dataSource?.count != 0 else { return nil }

        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        label.text = Text.Search.foundResult
        label.textAlignment = .center
        label.font = theme.fonts.dejaVuSansExtraLight(size: Device.isPad ? 26.7 : 16.7)
        label.textColor = .white
        headerView.addSubview(label)

        return headerView
    }
}

