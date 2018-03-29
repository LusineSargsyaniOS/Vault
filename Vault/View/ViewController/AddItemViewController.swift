//
//  AddItemViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/7/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class AddItemViewController: BackgroundImagedViewController<AddItemViewModel>, UITextFieldDelegate, Themed {
    override open var shouldReactOnEmptySpaceTap: Bool { return true }

    private var categoryView: DropDownView!
    private var articleView: DropDownView!
    private var statusView: DropDownView!
    private lazy var allDropDowns: [DropDownView] = {
        return [categoryView, articleView, statusView]
    }()

    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.gestureTapIgnoringView = containerView
        }
    }
    @IBOutlet private weak var categoryContainerView: UIView! {
        didSet {
            guard let categoryView: DropDownView = DropDownView.loadNib() else { return }

            categoryView.setup(on: categoryContainerView,
                               title: Text.AddItem.category,
                               doOnOpen: { [weak self] in self?.closeDropDownsIfNeeded(for: categoryView) },
                               cellSelected: { [weak self] index in self?.viewModel?.selectCategory(at: index) })

            self.categoryView = categoryView
        }
    }
    @IBOutlet private weak var articleContainerView: UIView! {
        didSet {
            guard let articleView: DropDownView = DropDownView.loadNib() else { return }

            articleView.setup(on: articleContainerView,
                              title: Text.AddItem.article,
                              doOnOpen: { [weak self] in self?.closeDropDownsIfNeeded(for: articleView) },
                              cellSelected: { [weak self] index in self?.viewModel?.selectArticle(at: index) })

            self.articleView = articleView
        }
    }
    @IBOutlet private weak var statusContainerView: UIView! {
        didSet {
            guard let statusView: DropDownView = DropDownView.loadNib() else { return }

            statusView.setup(on: statusContainerView,
                             title: Text.AddItem.status,
                             doOnOpen: { [weak self] in self?.closeDropDownsIfNeeded(for: statusView) },
                             cellSelected: { [weak self] index in self?.viewModel?.selectStatus(at: index) })

            self.statusView = statusView
        }
    }
    @IBOutlet private weak var serialNumberContainerView: UIView! {
        didSet {
            serialNumberContainerView.layer.cornerRadius = 4
        }
    }
    @IBOutlet private weak var commentContainerView: UIView! {
        didSet {
            commentContainerView.layer.cornerRadius = 4
        }
    }
    @IBOutlet private weak var addItemButton: RoundedButton! {
        didSet {
            addItemButton.alpha = 0.5
            addItemButton.isEnabled = false
            addItemButton.backgroundColor = UIColor.clear
            let addItemTitle = NSAttributedString(string: Text.AddItem.title,
                                                  attributes: [NSAttributedStringKey.underlineStyle : 1,
                                                               NSAttributedStringKey.foregroundColor: UIColor.white,
                                                               NSAttributedStringKey.font: theme.fonts.dejaVuSans(size: Device.isPad ?  23.5 : 13.5) ?? 13.5])
            addItemButton.setAttributedTitle(addItemTitle, for: .normal)
        }
    }
    @IBOutlet private weak var serailNumberTextField: UITextField! {
        didSet {
            serailNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            serailNumberTextField.delegate = self
            serailNumberTextField.placeholder = Text.AddItem.serialNumber
        }
    }

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.categoryItems()
        allDropDowns.forEach {
            $0.closeStateHeight = Device.isPad ? 60 : 38
            $0.openStateHeight = Device.isPad ? 200 : 153
        }
    }

    // MARK: Overriden functions
    override func setupSuccessHandling() {
        viewModel?.successHandler = { [weak self] responseCase in
            guard let strongSelf = self, let responseCase = responseCase else { return }

            switch responseCase {
            case .articles(let model):
                strongSelf.categoryView.dataSource = model.categories
                strongSelf.statusView.dataSource = model.status
                strongSelf.articleView.dataSource = model.articles
                strongSelf.categoryView.selectedTitle = model.categoryText
                strongSelf.articleView.selectedTitle = model.articleText
                strongSelf.statusView.selectedTitle = model.statusText
                strongSelf.addItemButton.isEnabled = model.isAllFieldsFilled
                strongSelf.addItemButton.alpha = model.isAllFieldsFilled ? 1.0 : 0.5
            case .addItem:
                strongSelf.handleGenericSuccess(with: Text.AddItem.successInfo, completion: { [weak self] in
                    self?.closeAddItem()
                })

            default: break
            }
        }
    }

    override open func setupNavigation() {
        super.setupNavigation()

        title = Text.AddItem.title

        let close = UIBarButtonItem.button(with: #imageLiteral(resourceName: "ic_clear_white_48px"), target: self, action: #selector(closeAddItem))
        navigationItem.leftBarButtonItem = close
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

    // MARK: Private helpers
    @objc private func closeAddItem() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    @objc private func textFieldDidChange() {
        self.viewModel?.serialNumber = serailNumberTextField.text
    }

    @IBAction private func addItemAction(_ sender: Any) {
        viewModel?.addItem()
    }

    private func closeDropDownsIfNeeded(for dropDownView: DropDownView) {
        allDropDowns.forEach { view in
            if view != dropDownView {
                view.close()
            }
        }
    }
}

