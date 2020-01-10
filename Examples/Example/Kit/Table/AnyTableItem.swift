//
//  AnyTableItemType.swift
//  Example
//
//  Created by Goncharov Anton on 06/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxDataSources

struct AnyTableItem: TableItemType {

    let item: TableItemType
    
    var id: String { item.id }
    var tableReuseIdentifier: String { item.tableReuseIdentifier }
    var rowHeight: CGFloat { item.rowHeight }
    var nestedType: NestedType { item.nestedType }

    init(_ item: TableItemType) {
        self.item = item
    }

    func configure(_ cell: UITableViewCell) {
        item.configure(cell)
    }

    func isEqualTo(_ other: TableItemType) -> Bool {
        item.isEqualTo(other)
    }
}

extension AnyTableItem: IdentifiableType {
    var identity : String { id }
}

extension AnyTableItem: Equatable {
    static func ==(lhs: AnyTableItem, rhs: AnyTableItem) -> Bool {
        return lhs.item.isEqualTo(rhs.item)
    }
}
