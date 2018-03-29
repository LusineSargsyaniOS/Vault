//
//  TableViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/4/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

protocol Setupable {
    associatedtype CellModel

    func setup(with cellModel: CellModel)
}

protocol Datasourced {
    associatedtype CellModel

    var dataSource: [CellModel]? { set get }
    var dataSourceChanged: (([CellModel]) -> Void)? { set get }
}

class TableViewController<Type: ViewModeling, Cell: UITableViewCell>: BackgroundImagedViewController<Type>, UITableViewDelegate, UITableViewDataSource where Type: Datasourced, Cell: Setupable, Cell.CellModel == Type.CellModel {

    open var style: UITableViewStyle { return .plain }

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupDataSourceHandling()
    }

    open func setupDataSourceHandling() {
        viewModel?.dataSourceChanged = { [weak self] dataSource in
            self?.setupEmptyState(show: dataSource.count != 0)
            self?.tableView.reloadData()
        }
    }

    open func setupEmptyState(show: Bool) {}

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath)
    }

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellModel = viewModel?.dataSource?[indexPath.row] {
            (cell as? Cell)?.setup(with: cellModel)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

    // MARK: Private helpers
    private func setupTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 1000), style: style)
        tableView.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.addInto(superView: self.view)

        if Bundle(for: Cell.self).path(forResource: String(describing: Cell.self), ofType: "nib") != nil {
            tableView.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
        } else {
            tableView.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
        }

        self.tableView = tableView
        self.gestureTapIgnoringView = tableView
    }
}
