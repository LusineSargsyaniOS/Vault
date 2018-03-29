//
//  DropDownView.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/6/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class DropDownView: UIView {
    @IBOutlet private weak var closedStateContainerView: UIView!
    @IBOutlet private weak var closedStateTitleLabel: UILabel!
    @IBOutlet private weak var openedStateContainerView: UIView!
    @IBOutlet private weak var openedStateTitleLabel: UILabel!
    @IBOutlet private weak var tabelView: UITableView!

    var openStateHeight: CGFloat = 0
    var closeStateHeight: CGFloat = 0 {
        didSet {
            if heightConstraint != nil {
                removeConstraint(heightConstraint!)
            }

            let height = NSLayoutConstraint.init(item: self,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .height,
                                                 multiplier: 1,
                                                 constant: closeStateHeight)
            self.addConstraint(height)
            self.height = height
        }
    }
    var height: NSLayoutConstraint?

    var dataSource: [DropDownCellModel] = [] {
        didSet {
            guard dataSource != oldValue else { return }

            tabelView.reloadData()
        }
    }

    var defaultTitle: String? {
        set {
            openedStateTitleLabel.text = newValue
            closedStateTitleLabel.text = newValue
        }
        get {
            return openedStateTitleLabel.text
        }
    }

    var selectedTitle: String? {
        set {
            closedStateTitleLabel.text = newValue
        }
        get {
            return closedStateTitleLabel.text
        }
    }

    private var doOnOpen: (() -> Void)?
    private var cellSelected: ((Int) -> Void)?

    private var viewToLayout: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
        setupTableView()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        viewToLayout = self
        while viewToLayout?.superview != nil {
            viewToLayout = viewToLayout?.superview
        }
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 4
        self.openedStateContainerView.layer.cornerRadius = 4
    }

    @IBAction private func dropDown(_ sender: UIButton) {
        open()
    }

    private func setupTableView() {
        self.tabelView.dataSource = self
        self.tabelView.delegate = self
        let classDescription = String(describing: DropDownCell.self)

        self.tabelView.register(UINib(nibName: classDescription, bundle: nil),
                                forCellReuseIdentifier: classDescription)
    }

    func open() {
        guard dataSource.count > 0 else { return }

        closedStateContainerView.isHidden = true
        openedStateContainerView.isHidden = false
        doOnOpen?()
        self.addShadow()
        dropDown(with: openStateHeight)
    }

    func close() {
        closedStateContainerView.isHidden = false
        openedStateContainerView.isHidden = true
        self.removeShadow()
        dropDown(with: closeStateHeight)
    }

    func setup(on containerView: UIView, title: String, doOnOpen: (() -> Void)?, cellSelected: ((Int) -> Void)?) {
        self.addInto(superView: containerView)
        self.defaultTitle = title
        self.doOnOpen = doOnOpen
        self.cellSelected = cellSelected
    }

    private func dropDown(with newValue: CGFloat) {
        guard newValue != height?.constant else { return }

        height?.constant = newValue

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.viewToLayout?.layoutIfNeeded()
        }
    }
}

extension DropDownView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        close()
        cellSelected?(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Device.isPad ? 50 : 39
    }
}

extension DropDownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cell.contentView.backgroundColor
        (cell as? DropDownCell)?.setup(with: dataSource[indexPath.row])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath)

        return cell
    }
}

