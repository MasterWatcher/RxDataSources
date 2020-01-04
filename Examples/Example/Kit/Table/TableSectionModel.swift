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
    let title: String?
    let items: [TableItemType]
}

extension TableSectionModel: SectionModelType {
    init(original: TableSectionModel, items: [TableItemType]) {
        self.title = original.title
        self.items = items
    }
}
