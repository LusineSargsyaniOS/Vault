//
//  ItemListViewModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/6/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

class ItemListViewModel<Type>: ViewModel<Type>, Datasourced {
    typealias CellModel = ItemCellModel

    var dataSourceChanged: (([CellModel]) -> Void)?

    var dataSource: [ItemCellModel]? {
        didSet {
            guard let dataSource = dataSource else { return }

            dataSourceChanged?(dataSource)
        }
    }
}
