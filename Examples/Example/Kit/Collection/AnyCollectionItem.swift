//
//  AnyCollectionItem.swift
//  Example
//
//  Created by Goncharov Anton on 09/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import RxDataSources

struct AnyCollectionItem: CollectionItemType {

    let item: CollectionItemType

    var id: String { item.id }
    var collectionReuseIdentifier: String { item.collectionReuseIdentifier }
    var itemSize: CGSize { item.itemSize }

    init(_ item: CollectionItemType) {
        self.item = item
    }

    func configure(_ cell: UICollectionViewCell) {
        item.configure(cell)
    }

    func isEqualTo(_ other: CollectionItemType) -> Bool {
        item.isEqualTo(other)
    }
}

extension AnyCollectionItem: IdentifiableType {
    var identity : String { id }
}

extension AnyCollectionItem: Equatable {
    static func ==(lhs: AnyCollectionItem, rhs: AnyCollectionItem) -> Bool {
        return lhs.item.isEqualTo(rhs.item)
    }
}

