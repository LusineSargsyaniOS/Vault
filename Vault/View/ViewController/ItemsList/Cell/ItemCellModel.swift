//
//  ItemCellModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/4/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

enum ItemStatus: Int, Themed {
    case lost = 10
    case stolen = 20
    case available = 30

    var statusColor: UIColor {
        switch self {
        case .available: return theme.colors.availableStatus
        case .lost: return theme.colors.lostStatus
        case .stolen: return theme.colors.stolenStatus
        }
    }

    var text: String {
        switch self {
        case .available: return Text.Status.available
        case .lost: return Text.Status.lost
        case .stolen: return Text.Status.stolen
        }
    }
}

struct ItemCellModel {
    var userItem: UserItem

    var currentStatus: ItemStatus? {
        return ItemStatus(rawValue: userItem.status)
    }
    var itemId: Int {
        return userItem.itemId
    }
    var statusColor: UIColor? {
        return ItemStatus(rawValue: userItem.status)?.statusColor
    }
    var title: String? {
        return userItem.serialNumber
    }

    init(userItem: UserItem) {
        self.userItem = userItem
    }
}
