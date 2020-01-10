//
//  MySectionModel.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxDataSources

struct TableSectionModel {
    let id: String
    let title: String?
    let items: [AnyTableItem]

    init(id: String = UUID().uuidString, title: String? = nil, items: [TableItemType]) {
        self.id = id
        self.title = title
        self.items = items.map(AnyTableItem.init)
    }
}

extension TableSectionModel: AnimatableSectionModelType {

    var identity: String { id }

    init(original: TableSectionModel, items: [AnyTableItem]) {
        self.id = original.id
        self.title = original.title
        self.items = items
    }
}
