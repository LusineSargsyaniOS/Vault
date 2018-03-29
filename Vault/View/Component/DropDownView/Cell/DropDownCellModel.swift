//
//  DropDownCellModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/8/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

struct DropDownCellModel {
    let status: ItemStatus?
    let title: String?

    init(status: ItemStatus? = nil, title: String? = nil) {
        self.status = status
        self.title = title
    }
}

extension DropDownCellModel: Equatable {
    static func ==(lhs: DropDownCellModel, rhs: DropDownCellModel) -> Bool {
        return lhs.status == rhs.status
            && lhs.title == rhs.title
    }
}
