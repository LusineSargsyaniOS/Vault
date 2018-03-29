//
//  ViewPresenter.swift
//  Vault
//
//  Created by Developer on 3/24/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

// Use if needed in successHandler implementation in viewcontroller to be able to differentiate which service call is succseed
enum ResponseSuccess {
    case login
    case profile(presenter: ProfilePresenter)
    case userItems
    case search
    case updateStatus
    case articles(presenter: AddItemPresentationModel)
    case categories
    case addItem
}

struct ProfilePresenter {
    let name: String
    let email: String
    var image: UIImage?
    var isImageLoading: Bool
}

struct AddItemPresentationModel {
    var categories: [DropDownCellModel] = []
    var articles: [DropDownCellModel] = []
    var status: [DropDownCellModel] = []
    var categorySelectedText: String = ""
    var articleSelectedText: String = ""
    var statusSelectedText: String = ""
    var serialNumber: String = ""
    let categoryDefaultText: String = Text.AddItem.category
    let articleDefaultText: String = Text.AddItem.article
    let statusDefaultText: String = Text.AddItem.status

    var isAllFieldsFilled: Bool {
        return !categorySelectedText.isEmpty
            && !articleSelectedText.isEmpty
            && !statusSelectedText.isEmpty
            && !serialNumber.isEmpty
    }

    var categoryText: String {
        return categorySelectedText.isEmpty ? categoryDefaultText : categorySelectedText
    }
    var articleText: String {
        return articleSelectedText.isEmpty ? articleDefaultText : articleSelectedText
    }
    var statusText: String {
        return statusSelectedText.isEmpty ? statusDefaultText : statusSelectedText
    }
}
