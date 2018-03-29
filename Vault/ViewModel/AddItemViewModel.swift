//
//  AddItemViewModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/7/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct AddItemViewModelInputs {
    let categoriesService: CategoryItemService
    let articlesService: ArticleItemService
    let addItemService: AddItemService
}

final class AddItemViewModel: ViewModel<AddItemViewModelInputs> {
    private var categories: [Category] = []
    private var articles: [String: [Article]] = [:]
    private var mappedCategories: [MappedCategory] = []
    private let statuses: [ItemStatus] = ItemStatus.allCases

    private var selectedCategory: Category?
    private var selectedArticle: Article?
    private var selectedStatus: ItemStatus?

    private var presentationModel = AddItemPresentationModel() {
        didSet {
            successHandler?(.articles(presenter: presentationModel))
        }
    }

    var serialNumber: String? {
        didSet {
            guard let serialNumber = serialNumber else { return }

            presentationModel.serialNumber = serialNumber
        }
    }

    func categoryItems() {
        self.retryHandler = { [weak self] in
            self?.categoryItems()
        }

        loadingHandler?(true)

        let parameters = CategoryParameters()

        inputs.categoriesService.call(routing: parameters, successHandler: { [weak self] response in

            if response?.status == true {
                self?.hiddingErrorHandler?()
                // result is received we can go on
                self?.categories = response?.result ?? []
                self?.articleItems()
            } else {
                // Some error, check message
                self?.loadingHandler?(false)
                self?.errorHandler?(CustomError.service(message: response?.message ?? ""))
            }

        }) { [weak self] error in
            self?.loadingHandler?(false)
            self?.errorHandler?(error)
        }
    }

    func articleItems() {
        self.retryHandler = { [weak self] in
            self?.loadingHandler?(true)
            self?.articleItems()
        }

        let parameters = ArticleItemParameters()

        inputs.articlesService.call(routing: parameters, successHandler: { [weak self] response in
            self?.loadingHandler?(false)

            if response?.status == true {
                self?.hiddingErrorHandler?()
                // result is received we can go on
                self?.articles = response?.result ?? [:]

                var mappedCategories: [MappedCategory] = []

                self?.categories.forEach { [weak self] category in
                    let categoryId = category.categoryId.stringValue
                    let mapped = MappedCategory(category: category, articles: self?.articles[categoryId] ?? [])
                    mappedCategories.append(mapped)
                }

                self?.mappedCategories = mappedCategories
                self?.presentationModel.categories = self?.allCategories() ?? []
                self?.presentationModel.status = self?.allStatus() ?? []
            } else {
                // Some error, check message
                self?.loadingHandler?(false)
                self?.errorHandler?(CustomError.service(message: response?.message ?? ""))
            }

        }) { [weak self] error in
            self?.loadingHandler?(false)
            self?.errorHandler?(error)
        }
    }

    func addItem() {
        guard let selectedStatus = selectedStatus,
            let selectedArticle = selectedArticle,
            let selectedCategory = selectedCategory,
            let serialNumber = serialNumber,
            let userId = Session.login?.userId else { return }

        self.retryHandler = { [weak self] in
            self?.addItem()
        }

        loadingHandler?(true)

        let addParam = AddItemParameters(status: selectedStatus.rawValue,
                                         category: selectedCategory.categoryId.rawValue,
                                         article: selectedArticle.articleId,
                                         serialNumber: serialNumber,
                                         userId: userId,
                                         securityPin: "")

        inputs.addItemService.call(routing: addParam, successHandler: { [weak self] response in
            self?.loadingHandler?(false)

            if response?.status == true {
                // result is received we can go on
                self?.hiddingErrorHandler?()
                self?.successHandler?(.addItem)
            } else {
                // Some error, check message
                self?.loadingHandler?(false)
                self?.errorHandler?(CustomError.service(message: response?.message ?? ""))
            }
        }) { [weak self] error in
            self?.loadingHandler?(false)
            self?.errorHandler?(error)
        }
    }

    func selectCategory(at index: Int) {
        guard 0..<mappedCategories.count ~= index else { return }

        let category = mappedCategories[index].category

        if category != selectedCategory {
            selectedCategory = category
            selectedArticle = nil
            presentationModel.categorySelectedText = category.categoryTitle
            presentationModel.articleSelectedText = ""
            presentationModel.articles = allArticlesForSelectedCategory(selectedCategory)
        }
    }

    func selectArticle(at index: Int) {
        guard let selectedCategory = selectedCategory,
            let articles = self.mappedCategories.filter({ $0.category == selectedCategory }).first?.articles,
            0..<articles.count ~= index else { return }

        let article = articles[index]

        if selectedArticle != article {
            selectedArticle = article
            presentationModel.articleSelectedText = article.articleTitle
        }
    }

    func selectStatus(at index: Int) {
        guard 0..<statuses.count ~= index else { return }

        let status = statuses[index]

        if selectedStatus != status {
            selectedStatus = status
            presentationModel.statusSelectedText = status.text
        }
    }

    // MARK: - Private helpers
    private func allCategories() -> [DropDownCellModel] {
        return self.mappedCategories.map { DropDownCellModel(title: $0.category.categoryTitle) }
    }

    private func allArticlesForSelectedCategory(_ selectedCategory: Category?) -> [DropDownCellModel] {
        guard let selectedCategory = selectedCategory,
            let articles = self.mappedCategories.filter({ $0.category == selectedCategory }).first?.articles  else { return [] }

        return articles.map { DropDownCellModel(title: $0.articleTitle) }
    }

    private func allStatus() -> [DropDownCellModel] {
        return statuses.map { DropDownCellModel(status: $0) }
    }

}
