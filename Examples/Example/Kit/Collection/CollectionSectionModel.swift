//
//  CollectionSectionModel.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxDataSources

struct CollectionSectionModel {
    let items: [CollectionItemType]
}

extension CollectionSectionModel: SectionModelType {
    init(original: CollectionSectionModel, items: [CollectionItemType]) {
        self.items = items
    }
}
