
//
//  UserItemsListViewModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/3/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct UserItemsListViewModelInputs {
    let userItemsService: UserItemsService
    let updateItemService: UpdateItemStatusService
}

final class UserItemsListViewModel: ItemListViewModel<UserItemsListViewModelInputs> {
    func fetchUserItems() {
        guard let userId = Session.login?.userId else { return }

        self.retryHandler = { [weak self] in
            self?.fetchUserItems()
        }

        self.loadingHandler?(true)

        let userItemsParameter = UserItemsParameters(userId: userId)
        let service: UserItemsService = UserItemsService()

        service.call(routing: userItemsParameter, successHandler: { [weak self] response in
            self?.loadingHandler?(false)

            guard let response = response else { return }

            if response.status == true {
                // result is received we can go on
                guard let result = response.result else { return }

                self?.dataSource = result.map { ItemCellModel(userItem: $0) }
                Session.ownedItemsCount = self?.dataSource?.count ?? 0
            } else {
                self?.errorHandler?(CustomError.service(message: response.message))
            }
        }) { [weak self] error in
            self?.loadingHandler?(false)
            self?.errorHandler?(error)
        }
    }

    func updateItemStatus(cellModel: ItemCellModel?, with statusId: ItemStatus?) {
        self.retryHandler = { [weak self] in
            self?.updateItemStatus(cellModel: cellModel, with: statusId)
        }

        loadingHandler?(true)

        guard let itemId = cellModel?.itemId,
            let statusId = statusId?.rawValue,
            let userId = Session.login?.userId else { return }

        let itemStatusParameter = UpdateItemStatusParameters(status: statusId,
                                                             userId: userId,
                                                             securityPin: ""/*securityPin*/,
                                                             itemId: String(itemId))

        inputs.updateItemService.call(routing: itemStatusParameter, successHandler: { [weak self] response in
            self?.loadingHandler?(false)

            if response?.status == true {
                self?.hiddingErrorHandler?()
                // result is received we can go on

                self?.successHandler?(.updateStatus)
            } else {
                // Some error, check message
                self?.errorHandler?(CustomError.service(message: response?.message ?? ""))
            }

        }) { error in
            self.loadingHandler?(false)
            self.errorHandler?(error)
        }
    }
}
