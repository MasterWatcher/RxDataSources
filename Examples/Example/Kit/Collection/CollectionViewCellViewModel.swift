//
//  CollectionViewCellViewModel.swift
//  Example
//
//  Created by Goncharov Anton on 04/01/2020.
//  Copyright © 2020 kzaher. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionCellViewModel: CollectionItemType {
    associatedtype CollectionCellType: ConfigurableCell & UICollectionViewCell where CollectionCellType.ViewModel == Self
}

extension CollectionCellViewModel {

    var collectionReuseIdentifier: String {
        String(describing: CollectionCellType.self)
    }

    //according to https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617711-itemsize
    var itemSize: CGSize {
        CGSize(width: 50, height: 50)
    }

    func configure(_ cell: UICollectionViewCell) {
        (cell as? CollectionCellType)?.configure(with: self)
    }
}
