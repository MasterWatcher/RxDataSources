//
//  CollectionViewItemT`ype.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import UIKit

protocol CollectionItemType {

    var id: String { get }
    var collectionReuseIdentifier: String { get }
    var itemSize: CGSize { get }
    func configure(_ cell: UICollectionViewCell)

    func isEqualTo(_ other: CollectionItemType) -> Bool
}

extension CollectionItemType where Self: Equatable {
    func isEqualTo(_ other: CollectionItemType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}
