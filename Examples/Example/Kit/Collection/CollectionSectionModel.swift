//
//  CollectionSectionModel.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxDataSources

struct CollectionSectionModel: Equatable {
    let id: String
    let items: [AnyCollectionItem]

    init(id: String = UUID().uuidString, items: [CollectionItemType]) {
        self.id = id
        self.items = items.map(AnyCollectionItem.init)
    }
}

extension CollectionSectionModel: AnimatableSectionModelType {

    var identity: String { id }

    init(original: CollectionSectionModel, items: [AnyCollectionItem]) {
        self.id = original.id
        self.items = items
    }
}
