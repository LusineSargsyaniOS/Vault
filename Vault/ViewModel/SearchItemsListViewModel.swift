//
//  SearchItemsListViewModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/5/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct SearchItemsListViewModelInputs {
    let search: SearchItemService
}

final class SearchItemsListViewModel: ItemListViewModel<SearchItemsListViewModelInputs> {
    func searchItem(serialNumber: String?) {
        // WARNING: Sometimes accountId is received nil from auth
        guard let accountId = Session.login?.accountId ?? Session.login?.userId,
            let serialNumber = serialNumber else { return }

        self.retryHandler = { [weak self] in
            self?.searchItem(serialNumber: serialNumber)
        }

        self.loadingHandler?(true)

        let searchItemParameters = SearchItemParameters(accountId: accountId,
                                                        serialNumber: serialNumber)

        inputs.search.call(routing: searchItemParameters, successHandler: { [weak self] response in
            guard let response = response else { return }

            self?.loadingHandler?(false)

            if response.status == true {
                self?.hiddingErrorHandler?()

                guard let result = response.result else { return }

                self?.dataSource = result.map { ItemCellModel(userItem: $0) }
            } else {
                self?.errorHandler?(CustomError.service(message: response.message))
            }

        }) { error in
            self.loadingHandler?(false)
            self.errorHandler?(error)
        }
    }
}
